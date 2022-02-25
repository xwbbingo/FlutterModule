import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:start_app/common/common.dart';
import 'package:start_app/generated/l10n.dart';
import 'package:start_app/net/dio_manager.dart';
import 'package:start_app/router/router_config.dart' as myRouter;
import 'package:start_app/ui/splash_screen.dart';
import 'package:start_app/utils/theme_util.dart';

void main() async {
  /// 修改问题: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized
  /// https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();

  runApp(WanAndroidApp());
}

/// 这个 widget 作用这个应用的顶层 widget.
/// widget 无状态的，继承 [StatelessWidget].
/// 对应的，有状态的，继承 [StatefulWidget]
class WanAndroidApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WanAndroidAppState();
  }
}

class WanAndroidAppState extends State<WanAndroidApp> {
  ///主题模式
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    _initAsync();
    themeData = ThemeUtil.getThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 标题
      title: AppConfig.appName,
      //是否去掉debug 图标
      debugShowCheckedModeBanner: AppConfig.isDebug,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeListResolutionCallback: (locales, supportedLocales) {
        print("当前系统环境：$locales");
        return;
      },
      theme: themeData,
      routes: myRouter.Router.generateRoute(),
      home: SplashScreen(),
      // home: MyHomePage(
      //   title: '语言切换',
      // ),
    );
  }

  void _initAsync() async {
    //初始化Dio
    await DioManager.instance.init();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _changeLanguage() async {
    print('修改前语言环境:${Intl.getCurrentLocale()}');
    await S.load(Locale('en', 'US'));
    //setState刷新页面改变语言
    setState(() {});
    print('修改后语言环境:${Intl.getCurrentLocale()}');
  }

  @override
  Widget build(BuildContext context) {
    double bigFontSize = 100;
    double smallFontSize = 16;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).pageHomeWelcome(Intl.getCurrentLocale()),
            ),
            Text(
              S.of(context).name,
            ),
            //没有context时可用
            // ModuleWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeLanguage,
        tooltip: 'change to english',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
