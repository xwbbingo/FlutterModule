import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:start_app/common/route/route_handlers.dart';

class AppRoutes {
  static final main = '/main';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
    });

    router.define(
      main,
      handler: mainHandler,
      transitionType: Platform.isAndroid
          ? TransitionType.material
          : TransitionType.cupertino,
    );
  }
}
