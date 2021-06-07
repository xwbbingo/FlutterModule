import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/http/api.dart';
import 'package:start_app/demo/flutter_architecture/page/login/sign_page.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/login/login_action.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';
import 'package:start_app/utils/toast_util.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageViewModel>(
      distinct: true,
      converter: (store) => LoginPageViewModel.fromStore(store, context),
      builder: (_, viewModel) => SignPage(viewModel: viewModel),
    );
  }
}

typedef OnLogin = void Function(String name, String password);
typedef OnAuth = void Function();

class LoginPageViewModel {
  static final String TAG = "LoginPageViewModel";
  final OnLogin onLogin;
  final OnAuth onAuth;
  final LoadingStatus status;

  LoginPageViewModel({this.onLogin, this.status, this.onAuth});

  static LoginPageViewModel fromStore(
      Store<AppState> store, BuildContext context) {
    return LoginPageViewModel(
        status: store.state.loginState.status,
        onLogin: (name, password) {
          LogUtil.v('name is $name, password is $password', tag: TAG);
          ToastUtil.show(msg: '此功能暂不支持');
          //store.dispatch(FetchLoginAction(context, name, password));
        },
        onAuth: () async {
          String code =
              await NavigatorUtil.goLoginWebview(context, Api.getOAuthUrl());
          LogUtil.v("login webview code $code");
          store.dispatch(AuthLoginAction(context, code));
        });
  }
}
