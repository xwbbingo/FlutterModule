import 'package:flutter/material.dart';

//class $NAME$ extends BaseWidget {
//  @override
//  BaseWidgetState attachState(){
//    return _$NAME$State();
//  };
//}
//
//class _$NAME$State extends BaseWidgetState<$NAME$> {
//  @override
//  Widget build(BuildContext context) {
//    return Container($END$);
//  }
//}

/// 封装一个通用的widget
abstract class BaseWidget extends StatefulWidget {
  BaseWidgetState baseWidgetState;

  @override
  BaseWidgetState createState() {
    baseWidgetState = attachState();
    return baseWidgetState;
  }

  BaseWidgetState attachState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  /// 导航栏是否显示
  bool _isAppBarShow = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    //AutomaticKeepAliveClientMixin 需要
    super.build(context);
    return Scaffold(
      appBar: _attachBaseAppBar(),
      body: Container(
        child: Stack(
          children: [
            _attachBaseContentWidget(context),
            _attachBaseLoadingWidget(),
            _attachBaseEmptyWidget(),
            _attachBaseErrorWidget(),
          ],
        ),
      ),
      floatingActionButton: fabWidget(),
    );
  }

  PreferredSizeWidget _attachBaseAppBar() {
    return PreferredSize(
      child: Offstage(
        offstage: !_isAppBarShow,
        child: attachAppBar(),
      ),
      preferredSize: Size.fromHeight(56),
    );
  }

  Widget attachAppBar();

  Widget fabWidget();

  _attachBaseContentWidget(BuildContext context) {}

  _attachBaseLoadingWidget() {}

  _attachBaseEmptyWidget() {}

  _attachBaseErrorWidget() {}
}
