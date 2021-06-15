import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/bloc/profile_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_stateless_widget.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/bloc_provider.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';

const items = [
  '项目',
  'star项目',
  '我关注的',
  '关注我的',
  '动态',
  '组织',
];

const SQUARE_BUTTON_HEIGHT = 127.0;
const PHOTO_BUTTON_HEIGHT = 200.0;
const REC_BUTTON_WIDTH = 255.0;
const REC_BUTTON_HEIGHT = 96.0;
const TOP_BAR_HEIGHT = 152.0;
const TOP_BAR_GRADIENT_HEIGHT = 133.0;
const BOTTOM_BAR_HEIGHT = 200.0;

class UserProfilePage
    extends BaseStatelessWidget<LoadingBean<UserBean>, ProfileBloc> {
  @override
  String getTitle(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    return bloc.name;
  }

  @override
  bool isShowAppBarActions() => true;

  @override
  int getItemCount(LoadingBean<UserBean> data) => 1;

  @override
  bool isLoading(LoadingBean<UserBean> data) {
    data != null ? data.isLoading : true;
  }

  @override
  void openWebView(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    NavigatorUtil.goWebView(context, bloc.name, bloc.bean.data.htmlUrl);
  }

  @override
  String getShareText(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    return bloc.bean.data.htmlUrl;
  }
}
