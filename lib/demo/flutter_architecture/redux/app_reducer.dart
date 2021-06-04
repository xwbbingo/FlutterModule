import 'app_state.dart';
import 'locale_reducer.dart';
import 'login/login_reducer.dart';
import 'theme_reducer.dart';
import 'user/user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    themeData: themeReducer(state.themeData, action),
    locale: localeReducer(state.locale, action),
    loginState: loginReducer(state.loginState, action),
    userState: userReducer(state.userState, action),
  );
}
