import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/redux/common_action.dart';

final themeReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refreshThemeData),
]);

ThemeData _refreshThemeData(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}
