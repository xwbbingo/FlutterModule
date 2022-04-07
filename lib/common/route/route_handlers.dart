import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/page/home/main_page.dart';

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});
