import 'package:start_app/model/article_model.dart';
import 'package:start_app/model/model_index.dart';
import 'package:start_app/net/net_index.dart';

ApisService _apisService = ApisService();

ApisService get apisService => _apisService;

class ApisService {
  /// 获取首页轮播数据
  void getBannerList(Function callback) async {
    dio.get(Apis.HOME_BANNER).then((response) {
      callback(BannerModel.fromJson(response.data));
    });
  }

  /// 获取首页置顶文章数据
  void getTopArticleList(Function callback, Function errorCallback) async {
    dio.get(Apis.HOME_TOP_ARTICLE_LIST).then((response) {
      callback(TopArticleModel.fromJson(response.data));
    }).catchError((err) {
      errorCallback(err);
    });
  }

  /// 获取首页文章列表数据
  void getArticleList(
      Function callback, Function errorCallback, int page) async {
    dio.get(Apis.HOME_ARTICLE_LIST + "/$page/json").then((response) {
      callback(ArticleModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }
}
