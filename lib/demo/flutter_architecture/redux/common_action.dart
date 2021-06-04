import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/models/user_bean.dart';

class InitAction {}

class InitCompleteAction {
  InitCompleteAction(
    this.token,
    this.userBean,
    this.isGuide,
  );

  final String token;
  final UserBean userBean;
  final bool isGuide;
}

//刷新主题
class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}

//刷新语言
class RefreshLocalAction {
  final Locale locale;

  RefreshLocalAction(this.locale);
}

//class RefreshAction {
//  final RefreshStatus refreshStatus;
//
//  RefreshAction(this.refreshStatus, this.type);
//}
