import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/bloc/home_bloc.dart';
import 'package:start_app/demo/flutter_architecture/bloc/repo_bloc.dart';
import 'package:start_app/demo/flutter_architecture/bloc/repo_main_bloc.dart';
import 'package:start_app/demo/flutter_architecture/common/image_path.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/bloc_provider.dart';
import 'package:start_app/demo/flutter_architecture/localizations/app_localizations.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/demo/flutter_architecture/page/home/drawer_page.dart';
import 'package:start_app/demo/flutter_architecture/page/home/home_page.dart';
import 'package:start_app/demo/flutter_architecture/page/home/repo_page.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';
import 'package:start_app/demo/flutter_architecture/util/size_util.dart';
import 'package:start_app/utils/screen_util.dart';
import 'package:start_app/utils/toast_util.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static final String TAG = "MainPage";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final PageController _pageController = PageController();

  TabController _tabController;

  UserBean _userBean;

  HomeBloc _homeBloc;
  RepoBloc _reposBloc;

  int _exitTime = 0;

  @override
  void initState() {
    super.initState();
    //RedPointManager.instance.addState(this);
    _tabController = TabController(vsync: this, length: 2);
    _userBean = LoginManager.instance.getUserBean();

    String userName = _userBean != null ? _userBean.login : "";

    _homeBloc = HomeBloc();
    _reposBloc = RepoMainBloc(userName);
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil.size = MediaQuery.of(context).size;
    final List<Choice> choices = <Choice>[];
    choices.add(Choice(
      title: AppLocalizations.of(context).currentlocal.home,
    ));
    choices.add(Choice(
      title: AppLocalizations.of(context).currentlocal.repository,
    ));
//    choices[2] = Choice(
//      title: AppLocalizations.of(context).currentlocal.event,
//    );
//    choices[3] = Choice(
//      title: AppLocalizations.of(context).currentlocal.issue,
//    );
    return WillPopScope(
        child: DefaultTabController(
          length: choices.length,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: DrawerPage(),
            ),
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      IconButton(
                        icon: ImageUtil.getCircleNetworkImage(
                            _userBean.avatarUrl ?? "",
                            36.0,
                            ImagePath.image_default_head),
                        onPressed: () {
                          //Scaffold.of(context).openDrawer();
                          _scaffoldKey.currentState.openDrawer();
                        },
                        tooltip:
                            //MaterialLocalizations.of(context).openAppDrawerTooltip,
                            'Open Drawer',
                      ),
//                      Offstage(
//                        offstage: !RedPointManager.instance.isUpgrade,
//                        child: Container(
//                          alignment: Alignment.topRight,
//                          padding: EdgeInsets.only(top: 5.0, right: 10.0),
//                          child: CommonUtil.getRedPoint(),
//                        ),
//                      )
                    ],
                  );
                },
              ),
              centerTitle: true,
              title: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.all(8.0),
                indicatorColor: Colors.white,
                tabs: choices.map((Choice choice) {
                  return Tab(
                    text: choice.title,
                  );
                }).toList(),
                onTap: (index) {
                  _pageController.jumpTo(ScreenUtil.screenWidthDp * index);
                },
              ),
              actions: [
                IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    //跳转至搜索
                    //NavigatorUtil.goSearch(context);
                  },
                ),
              ],
            ),
            //慎用TabBarView，假如现在有四个tab，如果首次进入app之后，
            //点击issue tab，动态 tab也会触发加载数据，并且立即销毁
            body: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BlocProvider<HomeBloc>(
                  child: HomePage(),
                  bloc: _homeBloc,
                ),
                BlocProvider<RepoBloc>(
                  child: RepoPage(RepoPage.PAGE_HOME),
                  bloc: _reposBloc,
                ),
              ],
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
            ),
          ),
        ),
        onWillPop: () {
          return _exitApp();
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
//    RedPointManager.instance.removeState(this);
//    RedPointManager.instance.dispose();
    super.dispose();
  }

  Future<bool> _exitApp() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      Navigator.of(context).pop();
      return Future.value(false);
    } else if ((DateTime.now().millisecondsSinceEpoch - _exitTime) > 2000) {
      ToastUtil.showMessgae('再按一次离开App');
      _exitTime = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(true);
    }
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}
