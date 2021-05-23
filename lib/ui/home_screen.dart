import 'package:flutter/material.dart';
import 'package:start_app/model/article_model.dart';
import 'package:start_app/model/model_index.dart';

///首页
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// 首页轮播图数据
  List<BannerBean> bannerList = <BannerBean>[];

  /// 首页文章列表数据
  List<ArticleBean> articleList = <ArticleBean>[];

  /// listview 控制器
  ScrollController scrollController = ScrollController();

  /// 是否显示悬浮按钮
  bool isShowFab = false;

  /// 页码，从0开始
  int page = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('首页'),
    );
  }
}
