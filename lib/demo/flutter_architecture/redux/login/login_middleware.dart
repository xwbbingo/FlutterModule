import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/bean/login_bean.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/user/user_action.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';
import 'package:start_app/utils/toast_util.dart';

import 'login_action.dart';

/// 4  通过Redux提供的combineReducers方法，将Action和操作方法绑定
/**
 * 1、combineReducers是Redux提供创建Reducer的方法。
 * 2、combineReducers泛型一定要是我们在State中定义的类型。
 * 3、TypedReducer是Redux提供的默认Reducer响应
 * 4、TypedReducer的第一个泛型必须是State中定义的类型。
 * 5、TypedReducer的第一个泛型即是我们定义的Action类型。
 * 6、TypedReducer的形参就是我们在book_action.dart中的定义的具体操作方法。
 * 7、dart语言中可以把方法当作参数
 * 8、这样就把Action和方法操作绑定了。有点类似EventBus哦
 */

/// 中间件,响应dispatch发送的action,做相应的逻辑处理
class LoginMiddleware extends MiddlewareClass<AppState> {
  static final String TAG = "LoginMiddleware";

  @override
  call(Store<AppState> store, action, next) {
    next(action);
    if (action is FetchLoginAction) {
      _doLogin(next, action.context, action.userName, action.password);
    } else if (action is AuthLoginAction) {
      _authLogin(next, action.context, action.code);
    }
  }

  Future<void> _doLogin(
      next, BuildContext context, String userName, String password) async {
    next(RequestingLoginAction());
    try {
      LoginBean loginBean =
          await LoginManager.instance.login(userName, password);
      if (loginBean != null) {
        String token = loginBean.token;
        LoginManager.instance.setToken(token, true);
        next(FetchUserAction(context, token));
      } else {
        ToastUtil.show(msg: "loginbean登录失败请重新登录");
        next(ErrorLoadingLoginAction());
      }
    } catch (e) {
      LogUtil.v(e, tag: TAG);
      ToastUtil.show(msg: "loginbean catch登录失败请重新登录");
      next(ErrorLoadingLoginAction());
    }
  }

  Future<void> _authLogin(next, BuildContext context, String code) async {
    next(RequestingLoginAction());
    try {
      String token = await LoginManager.instance.auth(code);
      if (token != null) {
        LoginManager.instance.setToken(token, true);
        next(FetchUserAction(context, token));
      } else {
        ToastUtil.show(msg: 'token登录失败请重新登录');
        next(ErrorLoadingLoginAction());
      }
    } catch (e) {
      LogUtil.v(e, tag: TAG);
      ToastUtil.show(msg: 'token catch登录失败请重新登录');
      next(ErrorLoadingLoginAction());
    }
  }
}
