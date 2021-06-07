import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bloc/home_bloc.dart';
import 'package:start_app/demo/flutter_architecture/models/user_bean.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
