import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/user/user_middleware.dart';

import 'app_reducer.dart';
import 'login/login_middleware.dart';

/// 1  创建Store，将Reducer和State绑定到Store中，Store定义在Widget中,
/// 同时也包含了发送Action
class ReduxStore {
  static Store<AppState> createStore() {
    return new Store<AppState>(
      //1.1初始化reducer
      appReducer,
      //1.2.初始化state
      initialState: AppState.initial(),
      //1.3初始化中间件
      middleware: [
        LoginMiddleware(),
        UserMiddleware(),
      ],
    );
  }
}
