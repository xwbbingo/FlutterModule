import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_app/common/common.dart';
import 'package:start_app/model/cart_model.dart';
import 'package:start_app/net/dio_manager.dart';
import 'package:start_app/page/home_page.dart';
import 'package:start_app/router/router_config.dart' as myRouter;
import 'package:start_app/ui/splash_screen.dart';
import 'package:start_app/utils/theme_util.dart';

import '../widgets/random_words.dart';

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
      theme: themeData,
      routes: myRouter.Router.generateRoute(),
      home: SplashScreen(),
    );
  }

  void _initAsync() async {
    //初始化Dio
    await DioManager.init();
  }
}

//void main() {
//  runApp(new MaterialApp(
//    title: 'My app', // used by the OS task switcher
//    home: new MyApp(),
//  ));
//}

class CartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        title: 'Flutter Food',
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
//          //child: new Text('Hello World'),
//          //child: new Text(wordPair.asPascalCase),
//          child: new RandomWords(),
//        ),
//      ),
    );
  }
}
