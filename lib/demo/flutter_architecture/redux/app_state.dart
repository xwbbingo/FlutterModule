import 'package:flutter/material.dart';
import 'package:start_app/utils/theme_util.dart';

import 'login/login_state.dart';
import 'user/user_state.dart';

class AppState {
  //主题
  final ThemeData themeData;

  //语言
  final Locale locale;

  //登录
  final LoginState loginState;

  //用户信息
  final UserState userState;

  //系统语言
  Locale platformLocale;

  AppState({
    this.themeData,
    this.locale,
    this.loginState,
    this.userState,
  });

  factory AppState.initial() => AppState(
        themeData: ThemeUtil.theme,
        locale: Locale('zh', 'CH'),
        loginState: LoginState.initial(),
        userState: UserState.initial(),
      );
}
