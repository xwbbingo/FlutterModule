import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/common/image_path.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_util.dart';
import 'package:start_app/demo/flutter_architecture/localizations/app_localizations.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/demo/flutter_architecture/manager/red_point_manager.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/common_action.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';

class DrawerPage extends StatefulWidget {
  static final String TAG = "DrawerPage";

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  UserBean _userBean;

  @override
  void initState() {
    super.initState();
    RedPointManager.instance.addState(this);
    _userBean = LoginManager.instance.getUserBean();
  }

  @override
  void dispose() {
    super.dispose();
    RedPointManager.instance.removeState(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_userBean.name ?? _userBean.login ?? "",
                style: YZStyle.normalTextWhite),
            accountEmail:
                Text(_userBean.email ?? "邮箱", style: YZStyle.smallTextWhite),
            currentAccountPicture: InkWell(
              onTap: () {
                NavigatorUtil.goUserProfile(context, _userBean.login,
                    _userBean.avatarUrl ?? "", "hero_drawer_image_");
              },
              child: Hero(
                tag: "hero_drawer_image_${_userBean?.login ?? ""}",
                child: ImageUtil.getCircleNetworkImage(
                  _userBean.avatarUrl ?? "",
                  YZSize.LARGE_IMAGE_SIZE,
                  ImagePath.image_default_head,
                ),
                transitionOnUserGestures: true,
              ),
            ),
            onDetailsPressed: () {
              NavigatorUtil.goUserProfile(context, _userBean.login,
                  _userBean.avatarUrl ?? "", "hero_drawer_image_");
            },
            otherAccountsPictures: <Widget>[
              InkWell(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: YZSize.NORMAL_IMAGE_SIZE,
                ),
                onTap: () {
                  _goEditProfile();
                },
              ),
            ],
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).currentlocal.trend ?? '',
                style: YZStyle.middleText),
            leading: Icon(
              Icons.trending_up,
              color: Colors.grey,
            ),
            onTap: () {
              //趋势
//              NavigatorUtil.goTrend(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).currentlocal.track ?? '',
                style: YZStyle.middleText),
            leading: Icon(Icons.directions_run, color: Colors.grey),
            onTap: () {
              //NavigatorUtil.goTrack(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).currentlocal.setting ?? '',
                style: YZStyle.middleText),
            leading: Icon(Icons.settings, color: Colors.grey),
            onTap: () {
              //NavigatorUtil.goSetting(context);
            },
          ),
          ListTile(
            title: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Text(AppLocalizations.of(context).currentlocal.about ?? '',
                    style: YZStyle.middleText),
                Offstage(
                  offstage: !RedPointManager.instance.isUpgrade,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: CommonUtil.getRedPoint(),
                  ),
                ),
              ],
            ),
            leading: Icon(Icons.info, color: Colors.grey),
            onTap: () {
//              NavigatorUtil.goAbout(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).currentlocal.share ?? '',
                style: YZStyle.middleText),
            leading: Icon(Icons.share, color: Colors.grey),
            onTap: () {
              // NavigatorUtil.goShare(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).currentlocal.logout ?? '',
                style: YZStyle.middleText),
            leading: Icon(Icons.power_settings_new, color: Colors.grey),
            onTap: () {
              _handleLogoutApp(context);
            },
          ),
        ],
      ),
    );
  }

  void _handleLogoutApp(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(dialogContext)
                  .currentlocal
                  .dialog_exit_title ??
              ''),
          content: Text(AppLocalizations.of(dialogContext)
                  .currentlocal
                  .dialog_exit_content ??
              ''),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  AppLocalizations.of(dialogContext).currentlocal.cancel ?? '',
                  style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text(
                AppLocalizations.of(dialogContext).currentlocal.ok ?? '',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Store<AppState> store = StoreProvider.of(context);
                store.dispatch(InitCompleteAction('', null, false));
                LoginManager.instance.clearAll();
//                CacheProvider provider = CacheProvider();
//                provider.delete();
                NavigatorUtil.goLogin(context);
              },
            )
          ],
        );
      },
    );
  }

  void _goEditProfile() async {
//    await NavigatorUtil.goEditProfile(context);
//    setState(() {
//      _userBean = LoginManager.instance.getUserBean();
//    });
  }
}
