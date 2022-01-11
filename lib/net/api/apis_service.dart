import 'package:start_app/model/article_model.dart';
import 'package:start_app/model/model_index.dart';
import 'package:start_app/net/api/apis.dart';
import 'package:start_app/net/dio_manager.dart';

ApisService _apisService = ApisService();

ApisService get apisService => _apisService;

class ApisService {
  /// 获取首页轮播数据
  void getBannerList(Function callback) async {
    DioManager.instance.get(Apis.HOME_BANNER).then((response) {
      callback(BannerModel.fromJson(response.data));
    });
  }

  /// 获取首页置顶文章数据
  void getTopArticleList(Function callback, Function errorCallback) async {
    DioManager.instance.get(Apis.HOME_TOP_ARTICLE_LIST).then((response) {
      callback(TopArticleModel.fromJson(response.data));
    }).catchError((err) {
      errorCallback(err);
    });
  }

  /// 获取首页文章列表数据
  void getArticleList(
      Function callback, Function errorCallback, int page) async {
    DioManager.instance
        .get(Apis.HOME_ARTICLE_LIST + "/$page/json")
        .then((response) {
      callback(ArticleModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }

  /// 获取广场列表数据
  void getSquareList(
      Function callback, Function errorCallback, int _page) async {
    DioManager.instance.get(Apis.SQUARE_LIST + "/$_page/json").then((response) {
      callback(ArticleModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }

  /// 获取公众号名称
  void getWXChaptersList(Function callback, Function errorCallback) async {
    DioManager.instance.get(Apis.WX_CHAPTERS_LIST).then((response) {
      callback(WXChaptersModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }
}
