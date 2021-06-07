import 'package:start_app/demo/flutter_architecture/bean/home_banner_bean.dart';
import 'package:start_app/demo/flutter_architecture/http/api.dart';
import 'package:start_app/demo/flutter_architecture/http/http_request.dart';

class HomeManager {
  factory HomeManager() => _getInstance();

  static HomeManager get instance => _getInstance();
  static HomeManager _instance;

  HomeManager._internal();

  static HomeManager _getInstance() {
    if (_instance == null) {
      _instance = new HomeManager._internal();
    }
    return _instance;
  }

  //首页轮播图数据
  Future<List<Data>> getHomeBanner() async {
    final response = await HttpRequest().get(Api.getBanner());
    if (response != null && response.result) {
      if (response.data != null) {
        HomeBannerBean bean = HomeBannerBean.fromJson(response.data);
        if (bean != null && bean.data != null) {
          return bean.data;
        }
      }
      return [];
    }
    return null;
  }
}
