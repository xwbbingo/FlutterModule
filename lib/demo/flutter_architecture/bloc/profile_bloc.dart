import 'package:flutter/src/widgets/framework.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';
import 'package:start_app/demo/flutter_architecture/manager/user_manager.dart';
import 'package:start_app/utils/toast_util.dart';

class ProfileBloc extends BaseBloc<LoadingBean<UserBean>> {
  final String name;

  ProfileBloc(this.name) {
    bean = new LoadingBean(isLoading: false);
  }

  @override
  Future getData() async {
    await _fetchProfile();
    await _fetchFollow();
  }

  @override
  void initData(BuildContext context) {
    onReload();
  }

  @override
  void onReload() async {
    showLoading();
    await _fetchProfile();
    await _fetchFollow();
    hideLoading();
  }

  Future _fetchProfile() async {
    final result = await UserManager.instance.getUserInfo(name);
    bean.data = result;

    if (result == null) {
      bean.isError = true;
    } else {
      bean.isError = false;
    }
  }

  Future _fetchFollow() async {
    if (!UserManager.instance.isYou(name) && bean.data != null) {
      final response = await UserManager.instance.isFollow(name);
      bool isFollow = false;
      if (response != null && response.result) {
        isFollow = true;
      }
      bean.data.isFollow = isFollow;
    }
  }

  void followOrUnFollow() async {
    showLoading();
    if (bean.data.isFollow) {
      await _unFollow();
    } else {
      await _follow();
    }
    hideLoading();
  }

  Future _follow() async {
    final response = await UserManager.instance.follow(name);
    if (response != null && response.result) {
      bean.data.isFollow = true;
    } else {
      ToastUtil.showMessgae('操作失败请重试');
    }
  }

  Future _unFollow() async {
    final response = await UserManager.instance.unFollow(name);
    if (response != null && response.result) {
      bean.data.isFollow = false;
    } else {
      ToastUtil.showMessgae('操作失败请重试');
    }
  }
}
