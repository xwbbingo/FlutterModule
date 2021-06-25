import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_cart/model/food_model.dart';
import 'package:start_app/demo/flutter_cart/widget/food_card_widget.dart';

import 'drop_down_header.dart';
import 'drop_down_menu.dart';
import 'drop_down_menu_controller.dart';

///商品筛选控件
class DropDownFilterWidget extends StatefulWidget {
  @override
  _DropDownFilterWidgetState createState() => _DropDownFilterWidgetState();
}

class _DropDownFilterWidgetState extends State<DropDownFilterWidget> {
  DropdownMenuController _dropdownMenuController = DropdownMenuController();

  List<String> _dropDownHeaderItems = ['综合', '销量', '价格'];
  List<SortCondition> _oneItems = [];
  List<SortCondition> _twoItems = [];
  //选中的条件
  SortCondition _selectSort;
  GlobalKey _stackKey = GlobalKey();

  //方法1 查找父级最近的Scaffold对应的ScaffoldState对象
  //ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
  //方法2 直接通过of静态方法来获取ScaffoldState
  //  ScaffoldState _state=Scaffold.of(context);

  @override
  void initState() {
    super.initState();
    _oneItems.add(SortCondition(name: '综合', isSelected: true));
    _oneItems.add(SortCondition(name: '信用', isSelected: false));
    _selectSort = _oneItems[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        key: _stackKey,
        children: [
          Column(
            children: <Widget>[
              DropDownHeader(
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                items: [
                  DropDownHeaderItem(_dropDownHeaderItems[0]),
                  DropDownHeaderItem(_dropDownHeaderItems[1]),
                  DropDownHeaderItem(_dropDownHeaderItems[2]),
                ],
                //点击某个item
                onItemTap: (index) {
                  //点击事件
                },
                headerHeight: 70,
//                headerBgColor: Colors.red,
                borderWidth: 2,
                borderColor: Color(0xFFeeede6),
                dividerHeight: 4,
//                dividerColor: Color(0xFFeeede6),
//                style: TextStyle(color: Color(0xFF666666), fontSize: 13),
//                dropDownStyle: TextStyle(
//                  fontSize: 13,
//                  color: Theme
//                      .of(context)
//                      .primaryColor,
//                ),
//                iconSize: 20,
//                iconColor: Color(0xFFafada7),
//                iconDropDownColor: Theme.of(context).primaryColor,
              ),
              buildFoodList(),
            ],
          ),
          //下拉菜单
          DropDownMenu(
            controller: _dropdownMenuController,
            menus: [
              DropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: _buildConditionListWidget(_oneItems, (value) {
                    _selectSort = value;
                    //头部进行重新赋值
                    _dropDownHeaderItems[0] = _selectSort.name;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
            ],
          ),
        ],
      ),
    );
  }

  ///商品列表
  buildFoodList() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(4),
        color: Colors.red,
        child: GridView.builder(
            //shrinkWrap: true,
            itemCount: foods.length,
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 4,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              return FoodCardWidget(foods[index]);
            }),
      ),
    );
  }

  _buildConditionListWidget(List<SortCondition> items, void itemOnTap(value)) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          SortCondition sortCondition = items[index];
          return GestureDetector(
            onTap: () {
              //将所有置为未选中状态
              for (var value in items) {
                value.isSelected = false;
              }
              sortCondition.isSelected = true;
              itemOnTap(sortCondition);
            },
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Text(
                    sortCondition.name,
                    style: TextStyle(
                      color:
                          sortCondition.isSelected ? Colors.red : Colors.grey,
                    ),
                  )),
                  sortCondition.isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.red,
                          size: 16,
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
          );
        },
        itemCount: items.length);
  }
}

//筛选时选中的条件
class SortCondition {
  String name;
  bool isSelected;

  SortCondition({this.name, this.isSelected});
}
