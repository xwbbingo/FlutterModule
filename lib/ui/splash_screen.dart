import 'package:flutter/material.dart';
import 'package:start_app/ui/main_screen.dart';
import 'package:start_app/utils/screen_util.dart';
import 'package:start_app/utils/util.dart';

/// 启动页面
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(

          /// builder(WidgetBuilder) 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
          ///  settings(RouteSettings) 包含路由的配置信息，如路由名称、是否初始路由（首页）。
          ///  maintainState：默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为false。
          ///  fullscreenDialog表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => route == null);
    });
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配初始化
    ScreenAdapter.init(context);
    return Center(
      child: Stack(
        children: [
          Container(
            //欢迎页面
            color: Theme.of(context).primaryColor,
            // ThemeUtils.dark ? Color(0xFF212A2F) : Colors.grey[200],
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  margin: EdgeInsets.all(2.0),
                  child: Card(
                    elevation: 0,
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.all(2.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage(Utils.getImgPath('ic_launcher_news')),
                      radius: 40.0,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
