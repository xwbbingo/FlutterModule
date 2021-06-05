import 'package:start_app/demo/flutter_architecture/common/config.dart';

class Api {
  static const String _BASE_URL = "https://api.github.com/";

  //1. 请求用户的 GitHub 身份
  static getOAuthUrl() {
    return "https://github.com/login/oauth/authorize?client_id"
        "=${Config.CLIENT_ID}&state=app&"
        "redirect_uri=${Config.AUTHORIZATION_URL}";
  }

  //2. 使用client_id、client_secret和code这三个参数获取用户的access_token
  // 用户被 GitHub 重定向回您的站点
  static getAuth(code) {
    return "https://github.com/login/oauth/access_token?"
        "client_id=${Config.CLIENT_ID}"
        "&client_secret=${Config.CLIENT_SECRET}"
        "&code=${code}";
  }

  static String authorizations() {
    return "${_BASE_URL}authorizations";
  }

  static getMyUserInfo() {
    return "${_BASE_URL}user";
  }
}
