import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/common/config.dart';
import 'package:start_app/demo/flutter_architecture/common/sp_const.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/demo/flutter_architecture/models/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/common_action.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';
import 'package:start_app/demo/flutter_architecture/util/locale_util.dart';
import 'package:start_app/demo/flutter_architecture/util/sp_util.dart';
import 'package:start_app/utils/theme_util.dart';
import 'package:start_app/utils/timer_util.dart';

import 'user_action.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    next(action);
    if (action is InitAction) {
      _init(store, next);
    } else if (action is StartCountdownAction) {
      _startCountdown(store, next, action.context);
    } else if (action is StopCountdownAction) {
      TimerUtil.cancelCountdown();
    }
  }

  Future<void> _init(Store<AppState> store, next) async {
    //初始化sp
    await SpUtil.instance.init();

//    //初始化数据库，并进行删除操作
//    CacheProvider provider = CacheProvider();
//    await provider.delete();

    //主题
    int theme = SpUtil.instance.getInt(SP_KEY_THEME_COLOR);
    if (theme != 0) {
      Color color = Color(theme);
      next(RefreshThemeDataAction(ThemeUtil.changeTheme(color)));
    }

    //语言
    int locale = SpUtil.instance.getInt(SP_KEY_LANGUAGE_COLOR);
    if (locale != 0) {
      next(RefreshLocalAction(LocaleUtil.changeLocale(store.state, locale)));
    }

    //用户信息
    String token = SpUtil.instance.getString(SP_KEY_TOKEN);
    UserBean userBean;
    var user = SpUtil.instance.getObject(SP_KEY_USER_INFO);
    if (user != null) {
      LoginManager.instance.setUserBean(user, false);
      userBean = UserBean.fromJson(user);
    }
    LoginManager.instance.setToken(token, false);

    //引导页
    String version = SpUtil.instance.getString(SP_KEY_SHOW_GUIDE_VERSION);
    String currentVersion = Config.SHOW_GUIDE_VERSION;
    next(InitCompleteAction(token, userBean, currentVersion != version));
//    //初始化本地数据
//    ReposManager.instance.initLanguageColors();
  }

  void _startCountdown(Store<AppState> store, next, BuildContext context) {
    TimerUtil.startCountDown(5, (value) {
      //回调至user_reducer中，更新页面的状态
      next(CountdownAction(value));

      if (value == 0) {
        _jump(context, store.state.userState.status,
            store.state.userState.isGuide);
      }
    });
  }

  void _jump(BuildContext context, LoginStatus status, bool isShowGuide) {
    if (isShowGuide) {
      NavigatorUtil.goGuide(context);
    } else if (status == LoginStatus.success) {
      NavigatorUtil.goMain(context);
    } else if (status == LoginStatus.error) {
      NavigatorUtil.goLogin(context);
    }
  }
}
