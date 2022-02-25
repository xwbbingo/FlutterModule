import 'package:flutter/foundation.dart';

/// DropdownMenuController use to show and hide drop-down menus.
/// Used for DropdownHeader and DropdownMenu passing[dropDownMenuTop], [menuIndex], [isShow] and [isShowHideAnimation].
class DropdownMenuController extends ChangeNotifier {
  /// [dropDownMenuTop] that the DropDownMenu top edge is inset from the top of the stack.
  ///
  /// Since the DropDownMenu actually returns a Positioned widget, the DropDownMenu must be inside the Stack
  /// vertically.
  double dropDownMenuTop;

  /// Current or last dropdown menu index, default is 0. 当前或最后一次点击下拉的下标，默认为0
  int menuIndex = 0;

  /// Whether to display a dropdown menu.
  bool isShow = false;

  /// Whether to display animations when hiding dropdown menu. 是否展示收缩动画
  bool isShowHideAnimation = false;

  //记录当前选中的下标,有下拉选择. (点击下拉却没有点击)
  int selectIndex = 0;

  /// Use to display DropdownMenu specified dropdown menu index.
  void show(int index) {
    isShow = true;
    menuIndex = index;
    notifyListeners();
  }

  /// Use to hide DropdownMenu. If you don't need to show the hidden animation, [isShowHideAnimation] pass in false, Like when you click on another DropdownHeaderItem.
  void hide({bool isShowHideAnimation = true}) {
    this.isShowHideAnimation = isShowHideAnimation;
    isShow = false;
    notifyListeners();
  }

  ///更新选中的下标
  void updateSelectIndex(int index) {
    selectIndex = index;
  }
}
