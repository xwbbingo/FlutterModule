import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';

/// 3 发送dispatch相关的action
//密码登录
class FetchLoginAction {
  final BuildContext context;
  final String userName;
  final String password;

  FetchLoginAction(this.context, this.userName, this.password);
}

//授权登录
class AuthLoginAction {
  final BuildContext context;
  final String code;

  AuthLoginAction(this.context, this.code);
}

//回调相关的action
class ReceivedLoginAction {
  ReceivedLoginAction(
    this.token,
    this.userBean,
  );

  final String token;
  final UserBean userBean;
}

class RequestingLoginAction {}

class ErrorLoadingLoginAction {}
