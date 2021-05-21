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
}
