import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/demo/flutter_architecture/models/login_bean.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/user/user_action.dart';
import 'package:start_app/utils/toast_util.dart';

import 'login_action.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    next(action);
    if (action is FetchLoginAction) {
      _doLogin(next, action.context, action.userName, action.password);
    }
  }

  Future<void> _doLogin(
      next, BuildContext context, String userName, String password) async {
    next(RequestingLoginAction());
    try {
      LoginBean loginBean =
          await LoginManager.instance.login(userName, password);
      if (loginBean != null) {
        String token = loginBean.token;
        LoginManager.instance.setToken(token, true);
        next(FetchUserAction(context, token));

//        UserBean userBean = await LoginManager.instance.getMyUserInfo();
//        if (userBean != null) {
//          next(ReceivedLoginAction(token, userBean));
//          //跳转到首页
//        } else {
//          ToastUtil.show(msg: "userbean登录失败请重新登录");
//          LoginManager.instance.setToken(null, true);
//        }
      } else {
        ToastUtil.show(msg: "loginbean登录失败请重新登录");
        next(ErrorLoadingLoginAction());
      }
    } catch (e) {
      ToastUtil.show(msg: "catch登录失败请重新登录");
      next(ErrorLoadingLoginAction());
    }
  }
}
