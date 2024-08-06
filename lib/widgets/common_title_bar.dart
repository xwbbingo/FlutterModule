// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:start_app/res/my_colors.dart';
//
// /// @Desc: 通用状态栏
// /// @Author: huangjiaming
// /// @Date:  2021/6/9
// class CommonTitleBar extends StatefulWidget implements PreferredSizeWidget {
//   CommonTitleBar({
//     Key key,
//     //搜索框圆角
//     this.borderRadius = 50,
//     //是否自动对焦，true  弹出输入法
//     this.autoFocus = false,
//     this.focusNode,
//     this.controller,
//     //输入框高度
//     this.searchHeight = 30,
//     this.value,
//     this.leftWidget,
//     this.suffix,
//     this.hintText,
//     this.onSearchTap,
//     this.onClear,
//     this.onCancel,
//     this.onChanged,
//     this.onSearch,
//     this.leftOnTap,
//     this.searchMargin,
//     this.leftDefWidgetMargin,
//     //默认高度
//     this.kToolbarHeight = 80,
//     this.isShowSearchIcon = true,
//     this.isShowDeleteIcon = true,
//     this.mode = true,
//     this.isShowLeftWidget = true,
//     this.title = '',
//     this.hintStyle,
//     this.importTextStyle,
//     this.titleWidget,
//     this.titleBarBottomWidget,
//     this.opacity = 1.0,
//     this.elevation = 1.0,
//     this.leadingWidth,
//     this.brightnessDark = false,
//     this.isCenterTitle = true,
//     this.rightWidget = const [],
//     this.isSearchEnabled = false,
//     this.isShowCommonTitle = true,
//     this.shadowColor = MyColors.transparent,
//     this.backgroundColor, // = MyColors.color_F9F9F9,
//     this.autoSystemOverlayStyle = true,
//     this.opacityBackGroundColor = MyColors.color_FFFFFF,
//   }) : super(key: key);
//   final double borderRadius;
//   final bool autoFocus;
//   //设置状态栏颜色 true  白色    false  黑色
//   bool brightnessDark;
//   final FocusNode focusNode;
//   final TextEditingController controller;
//
//   // 状态栏透明 0~1  1为不透明
//   double opacity;
//
//   //控制状态栏底部阴影效果
//   final double elevation;
//
//   // 左边按钮的宽度
//   double leadingWidth;
//
//   //使用什么颜色进行，透明渐变
//   final Color opacityBackGroundColor;
//
//   // 输入框高度 默认
//   double searchHeight;
//
//   // 默认输入内容
//   final String value;
//
//   //标题
//   final String title;
//
//   //中间标题  如果有标题 默认隐藏搜索框
//   Widget titleWidget;
//
//   // 最前面的组件
//   Widget leftWidget;
//
//   //底部控件
//   PreferredSizeWidget titleBarBottomWidget;
//
//   //是否显示左边的widget
//   final bool isShowLeftWidget;
//
//   // 搜索框内部右边控件
//   final Widget suffix;
//
//   // 提示文字
//   final String hintText;
//
//   // 输入框点击
//   final VoidCallback onSearchTap;
//
//   // 单独清除输入框内容
//   final VoidCallback onClear;
//
//   // 清除输入框内容并取消输入
//   final VoidCallback onCancel;
//
//   // 输入框内容改变
//   final ValueChanged onChanged;
//
//   // 点击键盘搜索
//   final ValueChanged onSearch;
//
//   //左边的点击回调
//   final VoidCallback leftOnTap;
//
//   //搜索框 上下左右间距
//   final EdgeInsets searchMargin;
//
//   //左边控件距离
//   final EdgeInsets leftDefWidgetMargin;
//
//   //bar 的高度
//   double kToolbarHeight;
//
//   //是否显示左边的搜索按钮？ 默认显示
//   final bool isShowSearchIcon;
//
//   //是否显示右边删除的Icon
//   final bool isShowDeleteIcon;
//
//   //标题模式  true    false 为搜索模式  暂定两种
//   final bool mode;
//
//   final TextStyle hintStyle;
//   final TextStyle importTextStyle;
//
//   //是否激活输入
//   final bool isSearchEnabled;
//
//   //是否显示整个tabBar
//   bool isShowCommonTitle;
//
//   //无论左边，右边是否有控件，标题始终居中显示。
//   final bool isCenterTitle;
//
//   //右边widget 可以多个
//   List<Widget> rightWidget;
//
//   //阴影颜色
//   Color shadowColor;
//
//   Color backgroundColor;
//
//   //状态栏色跟随系统主题而定,默认为true.  置false,由brightnessDark控制亮、暗
//   bool autoSystemOverlayStyle;
//
//   _CommonTitleBarState state;
//
//   @override
//   _CommonTitleBarState createState() {
//     return state = _CommonTitleBarState();
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
//
//   void setAlpha(double value) {
//     state.setAlpha(value);
//   }
//
//   ///改变右边控件
//   void setRightWidget(List<Widget> rightWidget) {
//     this.rightWidget = rightWidget;
//   }
//
//   ///改变左边控件
//   void setLeftWidget(Widget leftWidget) {
//     this.leftWidget = leftWidget;
//   }
//
//   ///改变标题控件
//   void setTitleWidget(Widget titleWidget) {
//     this.titleWidget = titleWidget;
//   }
//
//   ///设置状态栏颜色 true 白色   false  黑色
//   void setBrightness(bool isBrightnessDark) {
//     this.brightnessDark = isBrightnessDark;
//   }
//
//   ///刷新
//   void setState() {
//     state.setState(() {});
//   }
//
//   void setShowCommonTitleBar(bool isShowCommonTitle) {
//     this.isShowCommonTitle = isShowCommonTitle;
//   }
// }
//
// class _CommonTitleBarState extends State<CommonTitleBar> {
//   TextEditingController _controller;
//   FocusNode _focusNode;
//
//   bool get isFocus => _focusNode.hasFocus;
//
//   //监听控件输入的内容
//   bool get isTextEmpty => _controller.text.isEmpty;
//
//   String get hintText => widget.hintText;
//
//   //搜索提示字体样式
//   TextStyle get hintStyle =>
//       widget.hintStyle ??
//       TextStyle(fontSize: MyDimens.sp14, color: MyColors.color_999999);
//
//   //搜索输入字体样式
//   TextStyle get importTextStyle =>
//       widget.importTextStyle ??
//       TextStyle(fontSize: KMDimens.sp14, color: MyColors.color_333333);
//
//   //控件默认下来 top 高度
//   EdgeInsets get searchMargin =>
//       widget.searchMargin ?? EdgeInsets.fromLTRB(MyColors.dp8w, 0, 0, 0);
//
//   //控制左边默认返回控件 值控制默认，自定义的，自行控制
//   EdgeInsets get leftDefWidgetMargin =>
//       widget.leftDefWidgetMargin ??
//       EdgeInsets.only(left: KMDimens.dp15w, top: 0);
//
//   Widget get leading => widget.isShowLeftWidget
//       ? widget.leftWidget ??
//           Container(
//             height: widget.kToolbarHeight,
//             width: KMDimens.dp40w,
//             padding: leftDefWidgetMargin,
//             // margin: leftDefWidgetMargin,
//             child: Icon(
//               Icons.arrow_back_ios,
//               size: KMDimens.dp18w,
//               color: Colors.black,
//             ),
//           )
//       : null;
//
//   double get leadingWidth => widget.isShowLeftWidget
//       ? (widget.leadingWidth ?? KMDimens.dp50w)
//       : KMDimens.dp10w;
//
//   //中间标题
//   Widget get titleWidget => widget.mode
//       ? widget.titleWidget ??
//           Container(
//             child: Container(
//               child: Text(
//                 widget.title,
//                 style: TextStyle(
//                   color: MyColors.color_333333,
//                   fontSize: KMDimens.sp17,
//                 ),
//               ),
//             ),
//           )
//       : widget.titleWidget;
//
//   EdgeInsets marginDistance = EdgeInsets.only();
//
//   @override
//   Future<void> initState() {
//     _controller = widget.controller ?? TextEditingController();
//     _focusNode = widget.focusNode ?? FocusNode();
//     if (widget.value != null) _controller.text = widget.value;
//     //如果初始化有默认输入内容，执行回调
//     _controller.addListener(() {
//       setState(() {});
//       widget.onChanged?.call(_controller.text);
//     });
//     widgetsBindingAddPostFrameCallback();
//     super.initState();
//   }
//
//   GlobalKey globalKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     // setBrightnessDark();
//     return Visibility(
//         visible: widget.isShowCommonTitle,
//         child: Opacity(
//           opacity: 1,
//           child: Container(
//               height: widget.kToolbarHeight,
//               child: AppBar(
//                 centerTitle: widget.isCenterTitle,
//                 // brightness:
//                 //     widget.brightnessDark ? Brightness.light : Brightness.dark,
//                 toolbarHeight: widget.kToolbarHeight,
//                 elevation: widget.elevation,
//                 shadowColor: widget.shadowColor,
//                 // toolbarOpacity: widget.opacity,
//                 systemOverlayStyle: widget.autoSystemOverlayStyle
//                     ? null
//                     : widget.brightnessDark
//                         ? SystemUiOverlayStyle(
//                             statusBarColor: Colors.transparent,
//                             // systemNavigationBarIconBrightness: Brightness.light,
//                             statusBarIconBrightness: Brightness.light,
//                             statusBarBrightness: Brightness.dark,
//                           )
//                         : SystemUiOverlayStyle(
//                             statusBarColor: Colors.transparent,
//                             // systemNavigationBarIconBrightness: Brightness.light,
//                             statusBarIconBrightness: Brightness.dark,
//                             statusBarBrightness: Brightness.light,
//                           ),
//                 // backgroundColor:
//                 //     widget.backgroundColor ?? Theme.of(context).primaryColor,
//                 backgroundColor: Color.fromRGBO(
//                     Theme.of(context).primaryColor.red,
//                     Theme.of(context).primaryColor.green,
//                     Theme.of(context).primaryColor.blue,
//                     widget.opacity < 0
//                         ? 0
//                         : (widget.opacity > 1 ? 1 : widget.opacity)),
//                 titleSpacing: 0,
//                 bottom: widget.titleBarBottomWidget,
//                 leading: Center(
//                   child: MaterialButton(
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: widget.kToolbarHeight,
//                       child: leading,
//                     ),
//                     onPressed: widget.leftOnTap,
//                   ),
//                 ),
//                 leadingWidth: (leading == null) ? 0 : leadingWidth,
//                 title: Container(
//                   key: globalKey,
//                   margin: marginDistance,
//                   alignment: Alignment.center,
//                   height: widget.kToolbarHeight,
//                   child: titleWidget ??
//                       Container(
//                           margin: searchMargin,
//                           decoration: BoxDecoration(
//                             color: MyColors.color_f5f5f5,
//                             borderRadius:
//                                 BorderRadius.circular(widget.borderRadius),
//                           ),
//                           child: GestureDetector(
//                             onTap: widget.onSearchTap,
//                             child: Row(
//                               children: [
//                                 widget.isShowSearchIcon
//                                     ? SizedBox(
//                                         width: widget.searchHeight,
//                                         height: widget.searchHeight,
//                                         child: Icon(Icons.search,
//                                             size: KMDimens.dp20w,
//                                             color: MyColors.color_999999),
//                                       )
//                                     : SizedBox(),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: widget.isShowSearchIcon
//                                         ? EdgeInsets.only(left: 0)
//                                         : EdgeInsets.only(left: KMDimens.dp10w),
//                                     child: TextField(
//                                       maxLines: 1,
//                                       enabled: widget.isSearchEnabled,
//                                       autofocus: widget.autoFocus,
//                                       focusNode: _focusNode,
//                                       controller: _controller,
//                                       decoration: InputDecoration.collapsed(
//                                         border: InputBorder.none,
//                                         hintText: hintText ?? '',
//                                         hintStyle: hintStyle,
//                                       ),
//                                       style: importTextStyle,
//                                       textInputAction: TextInputAction.search,
//                                       onSubmitted: widget.onSearch,
//                                     ),
//                                   ),
//                                 ),
//                                 _suffix(),
//                               ],
//                             ),
//                           )),
//                 ),
//                 //右边控件集合
//                 actions: widget.rightWidget,
//               )),
//         ));
//   }
//
//   /// 清除输入框内容
//   void _onClearInput() {
//     _controller.clear();
//     if (!isFocus) _focusNode.requestFocus();
//     setState(() {});
//     widget.onClear?.call();
//   }
//
//   /// 取消输入框编辑
//   void onCancelInput() {
//     _controller.clear();
//     _focusNode.unfocus();
//     setState(() {});
//     widget.onCancel?.call();
//   }
//
//   ///最后控件
//   Widget _suffix() {
//     if (!widget.isShowDeleteIcon) {
//       return SizedBox();
//     }
//     if (!isTextEmpty) {
//       return GestureDetector(
//         onTap: _onClearInput,
//         child: SizedBox(
//           width: KMDimens.dp30w,
//           height: KMDimens.dp30h,
//           child: Icon(Icons.cancel,
//               size: KMDimens.dp16w, color: MyColors.color_999999),
//         ),
//       );
//     }
//     return widget.suffix ?? SizedBox();
//   }
//
//   void setBrightnessDark() {
//     if (!Platform.isAndroid) {
//       return;
//     }
//     LogUtil.v("当前${widget.brightnessDark}", tag: 'xwb');
//     if (!widget.brightnessDark) {
//       SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//       );
//       SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//     } else {
//       SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.dark,
//       );
//       SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     _focusNode?.dispose();
//     super.dispose();
//   }
//
//   ///设置透明度
//   void setAlpha(double value) {
//     if (value < 0) {
//       value = 0;
//     }
//     if (value >= 1) {
//       value = 1;
//     }
//     setState(() {
//       widget.shadowColor = MyColors.transparent;
//       // widget.backgroundColor = MyColors.transparent;
//       widget.opacity = value;
//     });
//   }
//
//   ///计算标题位置
//   void widgetsBindingAddPostFrameCallback() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (widget.isCenterTitle && widget.mode) {
//         if (!widget.isShowLeftWidget && widget.rightWidget.length == 0) {
//           return;
//         }
//         double screenWidth = MediaQuery.of(context).size.width;
//         final RenderBox box = globalKey.currentContext.findRenderObject();
//         double size = box.size.width;
//         double rightWidgetWidth = screenWidth - size - leadingWidth;
//         if (widget.rightWidget.length == 0) {
//           marginDistance = EdgeInsets.only(right: leadingWidth);
//           setState(() {});
//           return;
//         }
//         if (!widget.isShowLeftWidget && widget.rightWidget.length != 0) {
//           marginDistance = EdgeInsets.only(left: rightWidgetWidth);
//           setState(() {});
//           return;
//         }
//         if (leadingWidth > rightWidgetWidth) {
//           marginDistance = EdgeInsets.only(
//               right: (leadingWidth - rightWidgetWidth) < 0
//                   ? 0
//                   : leadingWidth - rightWidgetWidth);
//         } else {
//           marginDistance = EdgeInsets.only(
//               left: (rightWidgetWidth - leadingWidth) < 0
//                   ? 0
//                   : rightWidgetWidth - leadingWidth);
//         }
//         setState(() {});
//       }
//     });
//   }
// }
