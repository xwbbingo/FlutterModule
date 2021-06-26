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

  final double iconSize;
  final Color iconColor;
  final Color iconDropDownColor;

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
      this.selectStyle,
      this.normalStyle,
      this.iconSize = 20,
      this.iconColor = const Color(0xFFafada7),
      this.iconDropDownColor,
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

  bool _isShowDropDownItemWidget = false;
  double _screenWidth;
  int _menuCount;
  TextStyle _dropDownStyle;
  Color _iconDropDownColor;

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
    _dropDownStyle =
        widget.selectStyle ?? TextStyle(color: Colors.red, fontSize: 13);
    _iconDropDownColor = widget.iconDropDownColor ?? Colors.blue;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _menuCount = widget.items.length;

    //平分item, 可扩展下平铺item
    var gridView = GridView.count(
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
      height: widget.headerHeight,
      decoration: BoxDecoration(
          border: Border.all(
        color: widget.borderColor,
        width: widget.borderWidth,
      )),
      child: gridView,
    );
  }

  Widget _menu(DropDownHeaderItem item) {
    int index = widget.items.indexOf(item);
    int menuIndex = widget.controller.menuIndex;
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
          if (widget.controller.isShow) {
            widget.controller.hide(isShowHideAnimation: false);
          }
          widget.controller.show(index);
        }

        if (widget.onItemTap != null) {
          widget.onItemTap(index);
        }

        setState(() {});
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
                      style: index == menuIndex
                          ? item.selectStyle
                          : item.normalStyle,
                    ),
                  ),
                  Icon(
                    !_isShowDropDownItemWidget
                        ? item.iconData ?? Icons.arrow_drop_down
                        : item.iconDropDownData ??
                            item.iconData ??
                            Icons.arrow_drop_up,
                    color: _isShowDropDownItemWidget
                        ? _iconDropDownColor
                        : item.selectStyle?.color ?? widget.iconColor,
                    size: item.iconSize ?? widget.iconSize,
                  ),
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
  //
  final IconData iconData;
  final IconData iconDropDownData;
  //筛选图片大小
  final double iconSize;
  //筛选标题选中样式
  final TextStyle selectStyle;
  //筛选标题未选中样式
  final TextStyle normalStyle;

  DropDownHeaderItem(
    this.title, {
    this.iconData,
    this.iconDropDownData,
    this.iconSize,
    this.selectStyle = const TextStyle(color: Colors.red, fontSize: 14),
    this.normalStyle = const TextStyle(color: Colors.grey, fontSize: 13),
  });
}
