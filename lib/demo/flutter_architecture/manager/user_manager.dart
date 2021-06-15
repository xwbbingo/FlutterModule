import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/http/api.dart';
import 'package:start_app/demo/flutter_architecture/http/http_request.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/utils/text_util.dart';

class UserManager {
  factory UserManager() => _getInstance();

  static UserManager get instance => _getInstance();

  static UserManager _instance;

  UserManager._internal();

  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = UserManager._internal();
    }
    return _instance;
  }

  //用户信息
  Future<UserBean> getUserInfo(String userName) async {
    final response =
        await HttpRequest().get(Api.getUserInfo(userName), isCache: false);
    if (response != null && response.data != null) {
      if (UserManager.instance.isYou(userName)) {
        LoginManager.instance.setUserBean(response.data, true);
      }
      return UserBean.fromJson(response.data);
    }
    return null;
  }

  ///是不是自己
  bool isYou(String userName) {
    UserBean userBean = LoginManager.instance.getUserBean();
    if (userBean != null && TextUtil.equals(userBean.login, userName)) {
      return true;
    }
    return false;
  }

  ///检查是否关注别人  get 204 true 404 false
  isFollow(userName) async {
    String url = Api.isFollow(userName);
    return await HttpRequest().get(url, isCache: false);
  }

  follow(userName) async {
    String url = Api.follow(userName);
    return await HttpRequest().put(url, isCache: false);
  }

  unFollow(userName) async {
    String url = Api.unFollow(userName);
    return await HttpRequest().delete(url, isCache: false);
  }
}
