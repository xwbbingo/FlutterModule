import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';

import 'login_action.dart';
import 'login_state.dart';

const String TAG = "loginReducer";
var logger = Logger();

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, RequestingLoginAction>(_requestingLogin),
  TypedReducer<LoginState, ReceivedLoginAction>(_receivedLogin),
  TypedReducer<LoginState, ErrorLoadingLoginAction>(_errorLoadingLogin),
]);

LoginState _requestingLogin(LoginState state, action) {
  logger.d("_requestingLogin");
  return state.copyWith(status: LoadingStatus.loading);
}

LoginState _receivedLogin(LoginState state, action) {
  logger.d('_receivedLogin');
  return state.copyWith(status: LoadingStatus.success, token: action.token);
}

LoginState _errorLoadingLogin(LoginState state, action) {
  logger.d('_errorLoadingLogin');
  return state.copyWith(status: LoadingStatus.error);
}
