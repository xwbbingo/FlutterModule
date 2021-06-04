import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/models/user_bean.dart';

class FetchLoginAction {
  final BuildContext context;
  final String userName;
  final String password;

  FetchLoginAction(this.context, this.userName, this.password);
}

class AuthLoginAction {
  final BuildContext context;
  final String code;

  AuthLoginAction(this.context, this.code);
}

class ReceivedLoginAction {
  final String token;
  final UserBean user;

  ReceivedLoginAction(this.token, this.user);
}

class RequestingLoginAction {}

class ErrorLoadingLoginAction {}
