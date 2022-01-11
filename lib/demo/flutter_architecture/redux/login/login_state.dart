import 'package:start_app/demo/flutter_architecture/status/status.dart';

/// 2  reducer中的状态,变化后widget会变化
class LoginState {
  final LoadingStatus status;
  final String token;

  LoginState({this.status, this.token});

  factory LoginState.initial() {
    return LoginState(status: LoadingStatus.idle, token: '');
  }

  LoginState copyWith({LoadingStatus status, String token}) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }
}
