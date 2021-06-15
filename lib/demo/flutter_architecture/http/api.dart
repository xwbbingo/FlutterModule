import 'package:start_app/demo/flutter_architecture/common/config.dart';

class Api {
  ///wanandroid banner
  static getBanner() => "https://www.wanandroid.com/banner/json";

  static const String _BASE_URL = "https://api.github.com/";

  ///1. 请求用户的 GitHub 身份
  static getOAuthUrl() {
    return "https://github.com/login/oauth/authorize?client_id"
        "=${Config.CLIENT_ID}&state=app&"
        "redirect_uri=${Config.AUTHORIZATION_URL}";
  }

  ///2. 使用client_id、client_secret和code这三个参数获取用户的access_token
  /// 用户被 GitHub 重定向回您的站点
  static getAuth(code) {
    return "https://github.com/login/oauth/access_token?"
        "client_id=${Config.CLIENT_ID}"
        "&client_secret=${Config.CLIENT_SECRET}"
        "&code=${code}";
  }

  ///3. 使用access_token获取用户信息, token放在头部header
  static getMyUserInfo() {
    return "${_BASE_URL}user";
  }

  ///用户基本资料
  static getUserInfo(userName) {
    return '${_BASE_URL}users/$userName';
  }

  ///检查是否关注别人  get 204 true 404 false
  static isFollow(userName) {
    return '${_BASE_URL}user/following/$userName';
  }

  ///关注别人  put 204 true 404 false
  static follow(userName) {
    return '${_BASE_URL}user/following/$userName';
  }

  ///取消关注别人  delete 204 true 404 false
  static unFollow(userName) {
    return '${_BASE_URL}user/following/$userName';
  }

  ///此功能暂时不可用
  static String authorizations() {
    return "${_BASE_URL}authorizations";
  }

  static repos(sort) {
    sort ??= 'pushed';
    return '${_BASE_URL}user/repos?sort=$sort';
  }

  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return '${tab}page=$page&per_page=$pageSize';
      } else {
        return '${tab}page=$page';
      }
    } else {
      return '';
    }
  }
}
