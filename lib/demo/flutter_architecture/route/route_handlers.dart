import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/page/guide/guide_page.dart';
import 'package:start_app/demo/flutter_architecture/page/guide/splash_page.dart';
import 'package:start_app/demo/flutter_architecture/page/home/main_page.dart';
import 'package:start_app/demo/flutter_architecture/page/login/login_page.dart';
import 'package:start_app/demo/flutter_architecture/page/login/login_webview.dart';

import 'fluro_util.dart';

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

//var reposDetailHandler = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String reposOwner = FluroUtil.decode(params["reposOwner"]?.first);
//      String reposName = FluroUtil.decode(params["reposName"]?.first);
//      return BlocProvider<RepoDetailBloc>(
//        child: RepoDetailPage(),
//        bloc: RepoDetailBloc(reposOwner, reposName),
//      );
//    });
