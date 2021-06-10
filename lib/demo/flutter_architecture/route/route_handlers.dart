import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/commonui/widget/web_view_page.dart';
import 'package:start_app/demo/flutter_architecture/page/guide/guide_page.dart';
import 'package:start_app/demo/flutter_architecture/page/guide/splash_page.dart';
import 'package:start_app/demo/flutter_architecture/page/home/main_page.dart';
import 'package:start_app/demo/flutter_architecture/page/login/login_page.dart';
import 'package:start_app/demo/flutter_architecture/page/login/login_webview.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';

import 'fluro_util.dart';
import 'navigator_util.dart';

var splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

var guideHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return GuidePage();
});

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});

var loginWebviewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = FluroUtil.decode(params["url"]?.first);
  return LoginWebView(url);
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var webviewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = FluroUtil.decode(params["title"]?.first);
  String url = FluroUtil.decode(params["url"]?.first);
  String isAd = FluroUtil.decode(params["isAd"]?.first);
  return WebViewPage(
    title: title,
    url: url,
    onWillPop: isAd == 'true'
        ? (context) {
            Store<AppState> store = StoreProvider.of(context);
            LoginStatus status = store.state.userState.status;
            if (store.state.userState.isGuide) {
              NavigatorUtil.goGuide(context);
            } else if (status == LoginStatus.success) {
              NavigatorUtil.goMain(context);
            } else if (status == LoginStatus.error) {
              NavigatorUtil.goLogin(context);
            }
          }
        : null,
  );
});

//var reposDetailHandler = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String reposOwner = FluroUtil.decode(params["reposOwner"]?.first);
//      String reposName = FluroUtil.decode(params["reposName"]?.first);
//      return BlocProvider<RepoDetailBloc>(
//        child: RepoDetailPage(),
//        bloc: RepoDetailBloc(reposOwner, reposName),
//      );
//    });
