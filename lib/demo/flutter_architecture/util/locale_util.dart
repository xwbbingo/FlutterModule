import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';

class LocaleUtil {
  static Locale changeLocale(AppState state, int index) {
    Locale locale = state.platformLocale;
    switch (index) {
      case 1:
        locale = Locale('zh', 'CH');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    return locale;
  }
}
