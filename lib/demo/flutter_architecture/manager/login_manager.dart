import 'dart:io';

import 'package:start_app/application.dart';
import 'package:start_app/demo/flutter_architecture/bean/login_bean.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/common/config.dart';
import 'package:start_app/demo/flutter_architecture/common/sp_const.dart';
import 'package:start_app/demo/flutter_architecture/http/api.dart';
import 'package:start_app/demo/flutter_architecture/http/credentials.dart';
import 'package:start_app/demo/flutter_architecture/http/http_request.dart';
import 'package:start_app/demo/flutter_architecture/util/sp_util.dart';

//你需要构造函数不是每次都创建一个新的对象时，使用factory关键字。
//
//class 类名 {
//  单例公开访问点
//  factory 类名() =>_静态获取单例的方法()
//
//  静态私有成员，没有初始化
//  static 类名 _单例名;
//
//  私有构造函数
//  类名._构造函数名称() { 若要初始化}
//
//  对外暴露的单例
//  static 类名 _静态获取单例的方法() {
//  if (_单例名 == null) {
//  _单例名 = 类名._构造函数名称();
//  }
//  return _单例名;
//  }
//}

class LoginManager {
  factory LoginManager() => _getInstance();

  static LoginManager get instance => _getInstance();

  static LoginManager _instance;

  static LoginManager _getInstance() {
    if (_instance == null) {
      _instance = LoginManager._internal();
    }
    return _instance;
  }

  LoginManager._internal();

  String _token;
  UserBean _userBean;

  login(String userName, String password) async {
    _token = Credentials.basic(userName, password);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": Config.CLIENT_ID,
      "client_secret": Config.CLIENT_SECRET
    };

    String url = Api.authorizations();
    RequestBuilder requestBuilder = new RequestBuilder();
    requestBuilder
        .method(HttpMethod.POST)
        .url(url)
        .data(requestParams)
        .isCache(false);
    final response = await HttpRequest().builder(requestBuilder);

    if (response != null && response.data != null) {
      return LoginBean.fromJson(response.data);
    }
    return null;
  }

  auth(String code) async {
    final response = await HttpRequest().get(Api.getAuth(code), isCache: false);
    if (response != null && response.data != null) {
      var result = Uri.parse("startapp://oauth?" + response.data);
      var token = result.queryParameters["access_token"];
      var tokenType = result.queryParameters["token_type"];
      logger.v(token + "  " + tokenType);
      return token;
    }
    return null;
  }

  getMyUserInfo() async {
    final response =
        await HttpRequest().get(Api.getMyUserInfo(), isCache: false);
    if (response != null) {
      setUserBean(response.data, true);
      return getUserBean();
    }
    return null;
  }

  clearAll() async {
    setUserBean(null, true);
    setToken(null, true);
  }

  setUserBean(data, bool isNeedCache) {
    if (data == null) {
      _userBean = null;
    } else {
      _userBean = UserBean.fromJson(data);
    }
    if (isNeedCache) {
      SpUtil.instance.putObject(SP_KEY_USER_INFO, data);
    }
  }

  getUserBean() {
    return _userBean;
  }

  void setToken(String token, bool isNeedCache) {
    _token = token;
    if (isNeedCache) {
      SpUtil.instance.putString(SP_KEY_TOKEN, token ?? "");
    }
  }

  String getToken() {
    String auth = _token;
    if (_token != null && _token.length > 0) {
      auth = _token.startsWith("Basic") ? _token : "token " + _token;
    }
    return auth;
  }
}
