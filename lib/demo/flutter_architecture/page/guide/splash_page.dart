import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/common/image_path.dart';
import 'package:start_app/demo/flutter_architecture/common/url_const.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/user/user_action.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';
import 'package:start_app/utils/timer_util.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashPageViewModel>(
      distinct: true,
      //将Store转换为ViewModel 。 生成的ViewModel将传递给builder函数
      converter: (store) => SplashPageViewModel.fromStore(store, context),
      //使用BuildContext和ViewModel构建一个小部件。 ViewModel由converter函数创建
      builder: (context, viewModel) {
        return SplashPageContent(viewModel: viewModel);
      },
    );
  }
}

bool isLoad = false;

class SplashPageContent extends StatelessWidget {
  static final String TAG = "SplashPageContent";

  final SplashPageViewModel viewModel;

  const SplashPageContent({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoad) {
      isLoad = true;
      TimerUtil.delay(500, (value) {
        viewModel.onStartCountdown();
      });
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                InkWell(
                  child: Image(
                    image: AssetImage(ImagePath.image_splash_ad),
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    _gotoAd(context);
                  },
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(
                    top: 30.0,
                    right: 16.0,
                  ),
                  child: InkWell(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Text(
                          '跳过${viewModel.countdown}s',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      _jump(context);
                    },
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
          SizedBox(
            height: 18.0,
          ),
          Image(
            width: 64.0,
            height: 64.0,
            image: AssetImage(ImagePath.image_app),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'OpenGit',
            style: TextStyle(color: Colors.black, fontSize: 24.0),
          ),
          SizedBox(
            height: 18.0,
          ),
        ],
      ),
    );
  }

  void _gotoAd(BuildContext context) {
    viewModel.onStopCountdown();
    NavigatorUtil.goWebViewForAd(context, 'Yuzo Blog', BLOG);
  }

  void _jump(BuildContext context) {
    viewModel.onStopCountdown();
    if (viewModel.isShowGuide) {
      //未引导过,进入引导页
      NavigatorUtil.goGuide(context);
    } else if (viewModel.status == LoginStatus.success) {
      NavigatorUtil.goMain(context);
    } else if (viewModel.status == LoginStatus.error) {
      NavigatorUtil.goLogin(context);
    }
  }
}

class SplashPageViewModel {
  final LoginStatus status;
  final bool isShowGuide;
  final int countdown;
  final VoidCallback onStartCountdown;
  final VoidCallback onStopCountdown;

  SplashPageViewModel({
    @required this.status,
    this.isShowGuide,
    this.countdown,
    this.onStartCountdown,
    this.onStopCountdown,
  });

  static SplashPageViewModel fromStore(
      Store<AppState> store, BuildContext context) {
    return SplashPageViewModel(
      status: store.state.userState.status,
      isShowGuide: store.state.userState.isGuide,
      countdown: store.state.userState.countdown,
      onStartCountdown: () {
        store.dispatch(StartCountdownAction(context));
      },
      onStopCountdown: () {
        store.dispatch(StopCountdownAction());
      },
    );
  }
}
