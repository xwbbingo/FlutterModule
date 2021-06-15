import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bean/user_bean.dart';
import 'package:start_app/demo/flutter_architecture/bloc/profile_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_stateless_widget.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/bloc_provider.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/demo/flutter_architecture/manager/user_manager.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';
import 'package:start_app/utils/screen_util.dart';

class UserProfileNewPage
    extends BaseStatelessWidget<LoadingBean<UserBean>, ProfileBloc> {
  final String heroTag;

  UserProfileNewPage(this.heroTag);

  @override
  bool isShowAppBar(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    if (bloc.bean == null || bloc.bean.data == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String getTitle(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    return bloc.name;
  }

  @override
  bool isShowAppBarActions() => false;

  @override
  int getItemCount(LoadingBean<UserBean> data) => 1;

  @override
  bool isLoading(LoadingBean<UserBean> data) =>
      data != null ? data.isLoading : true;

  @override
  void openWebView(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    NavigatorUtil.goWebView(context, bloc.name, bloc.bean.data.htmlUrl);
  }

  @override
  String getShareText(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    return bloc.bean.data.htmlUrl;
  }

  @override
  Widget getChild(BuildContext context, LoadingBean<UserBean> bean) {
    if (bean == null || bean.data == null) {
      return Container();
    }
    return _UserProfilePage(userBean: bean.data, heroTag: heroTag);
  }
}

class _UserProfilePage extends StatefulWidget {
  final UserBean userBean;
  final String heroTag;

  _UserProfilePage({Key key, this.userBean, this.heroTag}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<_UserProfilePage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  TabController _tabController;

//  RepoUserBloc _repoUserBloc;
//  RepoUserStarBloc _repoUserStarBloc;
//  FollowersBloc _followersBloc;
//  FollowingBloc _followingBloc;
//  UserEventBloc _userEventBloc;
//  OrgBloc _orgBloc;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 6);

    var name = widget.userBean.login;
//    _repoUserBloc = RepoUserBloc(name);
//    _repoUserStarBloc = RepoUserStarBloc(name);
//    _followersBloc = FollowersBloc(name);
//    _followingBloc = FollowingBloc(name);
//    _userEventBloc = UserEventBloc(name);
//    _orgBloc = OrgBloc(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (c, s) => [
            SliverAppBar(
              expandedHeight: 206.0,
              pinned: true,
              title: _buildTitle(),
              actions: _buildAction(c),
              flexibleSpace: _buildFlexibleSpace(),
              bottom: _buildTabBar(),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitle() {
    return Text(
      widget.userBean.login,
      style: YZStyle.normalTextWhite,
    );
  }

  _buildAction(BuildContext context) {
    var menus = <PopupMenuItem<String>>[];
    menus.add(_getPopupMenuItem('browser', Icons.language, '浏览器打开'));
    menus.add(_getPopupMenuItem('share', Icons.share, '分享'));
    if (widget.userBean.isFollow != null &&
        !UserManager.instance.isYou(widget.userBean.login)) {
      menus.add(_getPopupMenuItem(
          'follow',
          widget.userBean.isFollow ? Icons.delete : Icons.add,
          widget.userBean.isFollow ? '取消关注' : '关注'));
    }
    return [
      PopupMenuButton(
        padding: const EdgeInsets.all(0.0),
        onSelected: (value) {
          _onPopSelected(context, value);
        },
        itemBuilder: (BuildContext context) => menus,
      )
    ];
  }

  _buildFlexibleSpace() {
    return FlexibleSpaceBar(
      centerTitle: true,
      background: Hero(
        tag: widget.heroTag + widget.userBean.login,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ImageUtil.getNetworkImage(widget.userBean.avatarUrl),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: new Container(
                color: Colors.black.withOpacity(0.1),
                width: ScreenUtil.screenWidthDp,
                height: 206,
              ),
            ),
          ],
        ),
        transitionOnUserGestures: true,
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      indicatorColor: Colors.white,
      tabs: [],
      onTap: (index) {
        _pageController.jumpTo(ScreenUtil.screenWidthDp * index);
      },
    );
  }

  void _onPopSelected(BuildContext context, String value) {
    switch (value) {
      case "browser":
        _openWebView(context);
        break;
      case 'share':
        _share(context);
        break;
      case 'follow':
        _follow(context);
        break;
    }
  }

  void _openWebView(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    NavigatorUtil.goWebView(context, bloc.name, bloc.bean.data.htmlUrl);
  }

  void _share(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
//    ShareUtil.share(bloc.bean.data.htmlUrl);
  }

  void _follow(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.followOrUnFollow();
  }

  PopupMenuItem<String> _getPopupMenuItem(
      String value, IconData icon, String title) {
    return PopupMenuItem<String>(
        value: value,
        child: ListTile(
          contentPadding: EdgeInsets.all(0.0),
          dense: false,
          title: Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Color(YZColors.textColor),
                  size: 22.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  title,
                  style: YZStyle.middleText,
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
