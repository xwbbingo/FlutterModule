import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:start_app/utils/toast_util.dart';

import '../net_index.dart';

/// 统一接口返回格式错误检测
class MyErrorInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    return options;
  }

  @override
  onError(DioError err) async {
    String errorMsg = DioManager.handleError(err);
    ToastUtil.show(msg: errorMsg);
    return err;
  }

  @override
  onResponse(Response response) async {
    var data = response.data;
    if (data is String) {
      data = json.decode(data);
    }
    if (data is Map) {
      int errorCode =
          data['errorCode'] ?? 0; // 表示如果data['errorCode']为空的话把 0赋值给errorCode
      String errorMsg = data['errorMsg'] ?? '请求失败[$errorCode]';
      if (errorCode == 0) {
        // 正常
        return response;
      } else if (errorCode == -1001 /*未登录错误码*/) {
//        User().clearUserInfo();
        dio.clear(); // 调用拦截器的clear()方法来清空等待队列。
//        SPUtil.clear();
//        goLogin();
        return dio.reject(errorMsg); // 完成和终止请求/响应
      } else {
        ToastUtil.show(msg: errorMsg);
        return dio.reject(errorMsg); // 完成和终止请求/响应
      }
    }
    return response;
  }

//  void goLogin() {
//    /// 在拿不到context的地方通过navigatorKey进行路由跳转：
//    /// https://stackoverflow.com/questions/52962112/how-to-navigate-without-context-in-flutter-app
//    navigatorKey.currentState.pushNamed(RouterName.login);
//  }
}
