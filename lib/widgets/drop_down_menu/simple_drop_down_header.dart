import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';

/// Signature for when a tap has occurred.
typedef OnItemTap<T> = void Function(T value, int index);

///筛选头 Dropdown header widget 没有下拉弹窗
class SimpleDropDownHeader extends StatefulWidget {
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

  final OnItemTap<DropDownHeaderItem> onItemTap;
  final List<DropDownHeaderItem> items;
  final GlobalKey stackKey;

  /// Creates a dropdown header widget, Contains more than one header items.
  const SimpleDropDownHeader(
      {Key key,
      this.headerBgColor = Colors.white,
      this.headerHeight = 48,
      this.borderWidth = 0,
      this.borderColor = const Color(0xFFeeede6),
      //item未设置时默认选中
      this.selectStyle = const TextStyle(color: Colors.red, fontSize: 14),
      //item未设置时正常
      this.normalStyle = const TextStyle(color: Colors.grey, fontSize: 13),
      this.iconSize = 20,
//      this.iconDropUpColor = const Color(0xFFafada7),
//      this.iconDropDownColor = Colors.blue,
      this.dividerHeight = 0,
      this.dividerColor = const Color(0xFFeeede6),
      this.onItemTap,
      @required this.items,
      @required this.stackKey})
      : super(key: key);

  @override
  _SimpleDropDownHeaderState createState() => _SimpleDropDownHeaderState();
}

class _SimpleDropDownHeaderState extends State<SimpleDropDownHeader>
    with SingleTickerProviderStateMixin {
  GlobalKey _keyDropDownHeader = GlobalKey();
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double _screenWidth = mediaQuery.size.width;
    int _menuCount = widget.items.length;

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
//      color: Colors.red,
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
    return GestureDetector(
      onTap: () {
        //重新build
        setState(() {
          //        KMToast.info("点击了${item.title} / $menuIndex / $select");
          if (widget.onItemTap != null) {
            // 1.判断_selectIndex == index, 相等 asc = !asc
            // 2.不相等,将所有 asc = false, 然后 再 asc = !asc
            _selectIndex = index;
            if (index == 0 || index == 1) {
              widget.items[2].asc = false;
            }
            if (index == 2) {
              item.asc = !item.asc;
            }
            if (index == 2) {
              LogUtil.v("当前${item.asc} / ${index} / $_selectIndex", tag: 'xwb');
            }
            widget.onItemTap(item, _selectIndex);
          }
        });
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
                      style: index == _selectIndex
                          ? item.selectStyle ?? widget.selectStyle
                          : item.normalStyle ?? widget.normalStyle,
                    ),
                  ),
//                  item.isShowIcon
//                      ? Icon(
//                          index == _selectIndex
//                              ? item.asc
//                                  ? item.iconDropUpData ?? Icons.arrow_drop_up
//                                  : item.iconDropDownData ??
//                                      Icons.arrow_drop_down
//                              : item.iconDefaultData ??
//                                  Icons.workspaces_outline,
//                          size: item.iconSize ?? widget.iconSize,
//                        )
//                      : SizedBox(),
                  item.isShowIcon
                      ? Image.asset(
                          index == _selectIndex
                              ? item.asc
                                  ? item.iconDropUpData ?? Icons.arrow_drop_up
                                  : item.iconDropDownData ??
                                      Icons.arrow_drop_down
                              : item.iconDefaultData ??
                                  Icons.workspaces_outline,
                          height: 10,
                          width: 8,
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

  //默认降序
  bool asc;

  //未选中时的图片
  final String iconDefaultData;

  //箭头向上的图标
  final String iconDropUpData;

  //箭头向下的图标
  final String iconDropDownData;

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
    this.asc = false,
    this.iconDefaultData,
    this.iconDropUpData,
    this.iconDropDownData,
    this.iconSize,
    this.selectStyle,
    this.normalStyle,
    this.isShowIcon = true,
  });
}
