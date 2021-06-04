import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';

import '../common_action.dart';
import 'user_action.dart';
import 'user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, InitCompleteAction>(_refresh),
  TypedReducer<UserState, CountdownAction>(_refreshCountdown),
]);

UserState _refresh(UserState state, action) {
  LoginStatus status = LoginStatus.error;
  if (action.userBean != null) {
    status = LoginStatus.success;
  }
  return state.copyWith(
    status: status,
    currentUser: action.userBean,
    token: action.token,
    isGuide: action.isGuide,
  );
}

UserState _refreshCountdown(UserState state, action) {
  return state.copyWith(countdown: action.countdown);
}
