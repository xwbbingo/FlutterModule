import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/redux/common_action.dart';

final localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocalAction>(_refreshLocale),
]);

Locale _refreshLocale(Locale locale, action) {
  locale = action.locale;
  return locale;
}
