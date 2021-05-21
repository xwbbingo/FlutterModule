import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:start_app/ui/ui_index.dart';
import 'package:start_app/utils/toast_util.dart';
import 'package:start_app/utils/util.dart';

///主页
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();

  /// tabs的名字
  final bottomBarTitles = ["首页", "广场", "公众号", "体系", "项目"];

  /// 当前选中的索引
  int _selectedIndex = 0; // 当前选中的索引

  /// 五个Tabs的内容
  var pages = [
    HomeScreen(),
    SquareScreen(),
    WeChatScreen(),
    SystemScreen(),
    ProjectScreen(),
  ];

  DateTime _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    //返回键控制退出
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(bottomBarTitles[_selectedIndex]),
            bottom: null,
            elevation: 0,
            actions: [
              IconButton(
                  icon: _selectedIndex == 1
                      ? Icon(Icons.add)
                      : Icon(Icons.search),
                  onPressed: () {
                    //跳转事件
                  })
            ],
          ),
          body: PageView.builder(
            itemBuilder: (context, index) => pages[index],
            itemCount: pages.length,
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: _buildImage(0, "ic_home"),
                label: bottomBarTitles[0],
              ),
              BottomNavigationBarItem(
                icon: _buildImage(1, "ic_square_line"),
                label: bottomBarTitles[1],
              ),
              BottomNavigationBarItem(
                icon: _buildImage(2, "ic_wechat"),
                label: bottomBarTitles[2],
              ),
              BottomNavigationBarItem(
                icon: _buildImage(3, "ic_system"),
                label: bottomBarTitles[3],
              ),
              BottomNavigationBarItem(
                icon: _buildImage(4, "ic_project"),
                label: bottomBarTitles[4],
              ),
            ],
            // 设置显示模式
            type: BottomNavigationBarType.fixed,
            // 当前选中项的索引
            currentIndex: _selectedIndex,
            // 选择的处理事件 选中变化回调函数
            onTap: _onItemTapped,
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      //两次点击间隔超过2秒则重新计时_
      _lastPressedAt = DateTime.now();
      ToastUtil.show(msg: '2秒内连续按两次返回键退出', gravity: ToastGravity.BOTTOM);
      return false;
    }
    return true;
  }

  Future<bool> _onWillPopDialog() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('提示'),
            content: new Text('确定退出应用吗？'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('再看一会', style: TextStyle(color: Colors.cyan)),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('退出', style: TextStyle(color: Colors.cyan)),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// tabs 底部的图片
  _buildImage(int index, String iconPath) {
    return Image.asset(Utils.getImgPath(iconPath),
        width: 22,
        height: 22,
        color: _selectedIndex == index
            ? Theme.of(context).primaryColor
            : Colors.grey[500]);
  }

  /// 底部导航点击
  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }
}
