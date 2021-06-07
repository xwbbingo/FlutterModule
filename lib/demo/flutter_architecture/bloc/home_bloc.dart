import 'package:flutter/src/widgets/framework.dart';
import 'package:start_app/demo/flutter_architecture/bean/home_bean.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';
import 'package:start_app/demo/flutter_architecture/manager/home_manager.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';

class HomeBloc extends BaseBloc<LoadingBean<HomeBean>> {
  static final String TAG = "HomeBloc";

  HomeBloc() {
    bean = LoadingBean(isLoading: false, data: HomeBean());
  }

  @override
  void initData(BuildContext context) async {
    onReload();
//    _checkUpgrade(context);
  }

  @override
  void getData() async {
    await _fetchHomeBanner();
    // await _fetchHomeList();
  }

  @override
  void onReload() async {
    showLoading();
    await getData();
    hideLoading();
  }

  _fetchHomeBanner() async {
    LogUtil.v('_fetchHomeBanner', tag: TAG);
    var result = await HomeManager.instance.getHomeBanner();
    if (result != null) {
      bean.isError = false;
      bean.data.banner = result;
    } else {
      bean.isError = true;
    }
  }

//  void _checkUpgrade(BuildContext context) {
//    TimerUtil.delay(200, (_) {
//      ReposManager.instance
//          .getReposReleases('Yuzopro', 'OpenGit_Flutter')
//          .then((result) {
//        if (result != null && result.length > 0) {
//          ReleaseBean bean = result[0];
//          if (bean != null) {
//            PackageInfo.fromPlatform().then((info) {
//              if (info != null) {
//                String version = info.version;
//                String serverVersion = bean.name;
//                int compare = UpdateUtil.compareVersion(version, serverVersion);
//                if (compare == -1) {
//                  RedPointManager.instance.isUpgrade = true;
//                  String url = "";
//                  if (bean.assets != null && bean.assets.length > 0) {
//                    ReleaseAssetBean assetBean = bean.assets[0];
//                    if (assetBean != null) {
//                      url = assetBean.downloadUrl;
//                    }
//                  }
//                  UpdateUtil.showUpdateDialog(
//                      context, serverVersion, bean.body, url);
//                }
//              }
//            });
//          }
//        }
//      }).catchError((_) {});
//    });
//  }
}
