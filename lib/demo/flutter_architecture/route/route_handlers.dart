import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/page/guide/guide_page.dart';
import 'package:start_app/demo/flutter_architecture/page/guide/splash_page.dart';
import 'package:start_app/demo/flutter_architecture/page/login_page.dart';

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
  return SplashPage();
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
