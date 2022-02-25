import 'package:flutter/material.dart';
import 'package:start_app/widgets/drop_down_menu/drop_down_menu_controller.dart';

/// Signature for when a tap has occurred.
typedef OnItemTap<T> = void Function(T value);

///筛选头 Dropdown header widget
class DropDownHeader extends StatefulWidget {
  //头部整个背景色
  final Color headerBgColor;
  //头部的高度
  final double headerHeight;
  //装饰的线宽
  final double borderWidth;
  //装饰的颜色
  final Color borderColor;

  //文本选中时的颜色
  final TextStyle selectStyle;
  //文本正常时的颜色
  final TextStyle normalStyle;
  //图标大小
  final double iconSize;

//  图标颜色跟随字体颜色
//  final Color iconDropUpColor;
//  final Color iconDropDownColor;

  //分割线高度
  final double dividerHeight;
  //分割线颜色
  final Color dividerColor;

  final DropdownMenuController controller;
  final OnItemTap onItemTap;
  final List<DropDownHeaderItem> items;
  final GlobalKey stackKey;

  /// Creates a dropdown header widget, Contains more than one header items.
  const DropDownHeader(
      {Key key,
      this.headerBgColor = Colors.white,
      this.headerHeight = 40,
      this.borderWidth = 1,
      this.borderColor = const Color(0xFFeeede6),
      //item未设置时默认选中
      this.selectStyle = const TextStyle(color: Colors.red, fontSize: 14),
      //item未设置时正常
      this.normalStyle = const TextStyle(color: Colors.grey, fontSize: 13),
      this.iconSize = 20,
//      this.iconDropUpColor = const Color(0xFFafada7),
//      this.iconDropDownColor = Colors.blue,
      this.dividerHeight = 20,
      this.dividerColor = const Color(0xFFeeede6),
      this.onItemTap,
      @required this.controller,
      @required this.items,
      @required this.stackKey})
      : super(key: key);

  @override
  _DropDownHeaderState createState() => _DropDownHeaderState();
}

class _DropDownHeaderState extends State<DropDownHeader>
    with SingleTickerProviderStateMixin {
  GlobalKey _keyDropDownHeader = GlobalKey();

  //是否展示下拉
  bool _isShowDropDownItemWidget = false;
  double _screenWidth;
  int _menuCount;
//  TextStyle _dropDownStyle;
//  Color _iconDropDownColor;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onController);
  }

  _onController() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    _dropDownStyle = widget.selectStyle;
//    _iconDropDownColor = widget.iconDropDownColor ;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _menuCount = widget.items.length;

    //平分item, 可扩展下平铺item
    var gridView = GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0),
      crossAxisCount: _menuCount,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: (_screenWidth / _menuCount) / widget.headerHeight,
      children: widget.items.map((item) {
        return _menu(item);
      }).toList(),
    );

    return Container(
      key: _keyDropDownHeader,
//      height: widget.headerHeight,
      alignment: Alignment.center,
//      decoration: BoxDecoration(
//          border: Border.all(
//        color: widget.borderColor,
//        width: widget.borderWidth,
//      )),
      child: gridView,
    );
  }

  Widget _menu(DropDownHeaderItem item) {
    //当前item在集合中的下标
    int index = widget.items.indexOf(item);
    //点击头部时的下标
    int menuIndex = widget.controller.menuIndex;
    //选中的下标
    int select = widget.controller.selectIndex;
    _isShowDropDownItemWidget = index == menuIndex && widget.controller.isShow;
    print(
        '提示：$index ---- $_isShowDropDownItemWidget ---- ${(index == menuIndex)} ----- ${widget.controller.isShow}');
    return GestureDetector(
      onTap: () {
        final RenderBox overlay =
            widget.stackKey.currentContext.findRenderObject() as RenderBox;

        final RenderBox dropDownItemRenderBox =
            _keyDropDownHeader.currentContext.findRenderObject() as RenderBox;

        var position =
            dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
//        print("POSITION : $position ");
        var size = dropDownItemRenderBox.size;
//        print("SIZE : $size");

        widget.controller.dropDownMenuTop = size.height + position.dy;

        if (index == menuIndex) {
          if (widget.controller.isShow) {
            widget.controller.hide();
          } else {
            widget.controller.show(index);
          }
        } else {
          //正在展示则关闭
          if (widget.controller.isShow) {
            widget.controller.hide(isShowHideAnimation: false);
          }
          widget.controller.show(index);
        }

        if (widget.onItemTap != null) {
          widget.onItemTap(index);
        }
        //重新build
        //setState(() {});
      },
      child: Container(
        color: widget.headerBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
//                      style: _isShowDropDownItemWidget
//                          ? _dropDownStyle
//                          : widget.selectStyle.merge(item.selectStyle)
                      //自定义的style优先级大于默认的style
                      style: index == select
                          ? item.selectStyle ?? widget.selectStyle
                          : item.normalStyle ?? widget.normalStyle,
                    ),
                  ),
                  item.isShowIcon
                      ? Icon(
                          _isShowDropDownItemWidget
                              ? item.iconDropDownData ?? Icons.arrow_drop_up
                              : item.iconDropUpData ?? Icons.arrow_drop_down,
//                    color: _isShowDropDownItemWidget
//                        ? _iconDropDownColor
//                        : item.selectStyle?.color ?? widget.iconColor,
                          //自定义的style优先级大于默认的style
                          color: (index == select)
                              ? item.selectStyle?.color ??
                                  widget.selectStyle?.color
                              : item.normalStyle?.color ??
                                  widget.normalStyle?.color,
                          size: item.iconSize ?? widget.iconSize,
                        )
                      : SizedBox(),
                ],
              ),
            ),
            //分割线, 最后不用画
            index == widget.items.length - 1
                ? Container()
                : Container(
                    height: widget.dividerHeight,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: widget.dividerColor, width: 1),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class DropDownHeaderItem {
  //筛选标题
  final String title;
  //箭头向上的图标
  final IconData iconDropUpData;
  //箭头向下的图标
  final IconData iconDropDownData;
  //筛选图片大小
  final double iconSize;
  //筛选标题选中样式
  final TextStyle selectStyle;
  //筛选标题未选中样式
  final TextStyle normalStyle;
  //是否显示图标, 例：仅一个时不显示图标
  final bool isShowIcon;

  DropDownHeaderItem(
    this.title, {
    this.iconDropUpData,
    this.iconDropDownData,
    this.iconSize,
    this.selectStyle,
    this.normalStyle,
    this.isShowIcon = true,
  });
}
