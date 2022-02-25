import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:start_app/application.dart';
import 'package:start_app/demo/flutter_architecture/localizations/app_localizations_delegate.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/redux_store.dart';
import 'package:start_app/demo/flutter_architecture/route/routes.dart';
import 'package:start_app/utils/sp_util.dart';

import 'redux/common_action.dart';

void main() async {
  /// 修改问题: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized
  /// https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();
  await SPUtil.getInstance();

  Application.store = ReduxStore.createStore();

  //初始化 fluro 的配置
  final router = FluroRouter();
  AppRoutes.configureRoutes(router);
  Application.router = router;

  runApp(GitApp(
    store: Application.store,
  ));
}

class GitApp extends StatefulWidget {
  final Store<AppState> store;

  const GitApp({Key key, this.store}) : super(key: key);

  @override
  _GitAppState createState() => _GitAppState();
}

class _GitAppState extends State<GitApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: widget.store,
        child: StoreConnector<AppState, _ViewModel>(
          converter: _ViewModel.fromStore,
          builder: (context, vm) {
            return MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizationsDelegate.delegate
              ],
              locale: vm.locale,
              // supportedLocales: [vm.locale],
              supportedLocales: [
                Locale('zh', 'CH'),
                Locale('en', 'US'),
              ],
              theme: vm.themeData,
              onGenerateRoute: Application.router.generator,
              //home: LoginPage(),
            );
          },
        ));
  }
}

class _ViewModel {
  final ThemeData themeData;
  final Locale locale;

  _ViewModel({this.themeData, this.locale});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      themeData: store.state.themeData,
      locale: store.state.locale,
    );
  }
}
