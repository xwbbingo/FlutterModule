import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:start_app/common/common.dart';
import 'package:start_app/model/article_model.dart';
import 'package:start_app/model/model_index.dart';
import 'package:start_app/net/api/apis_service.dart';
import 'package:start_app/ui/base_widget.dart';
import 'package:start_app/utils/toast_util.dart';
import 'package:start_app/widgets/custom_cached_image.dart';
import 'package:start_app/widgets/item_article_list.dart';

///首页
class HomeScreen extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> attachState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseWidgetState<HomeScreen> {
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

  /// 刷新加载控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerList.add(null);
    showLoading().then((value) {
      getBannerList();
      getTopArticleList();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {

      }
      if (scrollController.offset < 200 && isShowFab) {
        setState(() {
          isShowFab = false;
        });
      } else if (scrollController.offset >= 200 && !isShowFab) {
        setState(() {
          isShowFab = true;
        });
      }
    });
  }

  @override
  Widget attachAppBar() {
    return AppBar(
      title: Text(''),
    );
  }

  @override
  Widget attachContentWidget(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载更多~");
            } else if (mode == LoadStatus.loading) {
//              body =  CupertinoActivityIndicator();
              body = Wrap(
                spacing: 6,
                children: <Widget>[
                  CupertinoActivityIndicator(),
                  Text("加载中..."),
                ],
              );
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松手,加载更多!");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onRefresh: getTopArticleList,
        onLoading: getMoreArticleList,
        child: ListView.builder(
          itemBuilder: buildItemView,
          physics: AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          itemCount: articleList.length + 1,
        ),
      ),
      floatingActionButton: !isShowFab
          ? null
          : FloatingActionButton(
              heroTag: "home",
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //回到顶部时执行的动画
                scrollController.animateTo(0,
                    duration: Duration(milliseconds: 2000), curve: Curves.ease);
              }),
    );
  }

  @override
  void onClickErrorWidget() {
    showLoading().then((value) {
      getBannerList();
      getTopArticleList();
    });
  }

  /// 获取轮播数据
  Future getBannerList() async {
    apisService.getBannerList((BannerModel bannerModel) {
      if (bannerModel.data.length > 0) {
        setState(() {
          bannerList = bannerModel.data;
        });
      }
    });
  }

  /// 获取置顶文章数据
  Future getTopArticleList() async {
    apisService.getTopArticleList((TopArticleModel topArticleModel) {
      if (topArticleModel.errorCode == Constants.STATUS_SUCCESS) {
        topArticleModel.data.forEach((element) {
          element.top = 1;
        });
        articleList.clear();
        articleList.addAll(topArticleModel.data);
      }
      // 获取文章列表
      getArticleList();
    }, (DioError dioError) {
      showError();
    });
  }

  /// 获取文章列表数据
  Future getArticleList() async {
    page = 0;
    apisService.getArticleList((ArticleModel articleModel) {
      if (articleModel.errorCode == Constants.STATUS_SUCCESS) {
        if (articleModel.data.datas.length > 0) {
          showContent().then((value) {
            refreshController.refreshCompleted(resetFooterState: true);
            setState(() {
              articleList.addAll(articleModel.data.datas);
            });
          });
        } else {
          showEmpty();
        }
      } else {
        showError();
        ToastUtil.show(msg: articleModel.errorMsg);
      }
    }, (DioError dioError) {
      showError();
    }, page);
  }

  /// 获取更多文章列表数据
  Future getMoreArticleList() async {
    page++;
    apisService.getArticleList((ArticleModel articleModel) {
      if (articleModel.errorCode == Constants.STATUS_SUCCESS) {
        if (articleModel.data.datas.length > 0) {
          refreshController.loadComplete();
          setState(() {
            articleList.addAll(articleModel.data.datas);
          });
        } else {
          refreshController.loadNoData();
        }
      } else {
        refreshController.loadFailed();
        ToastUtil.show(msg: articleModel.errorMsg);
      }
    }, (DioError dioError) {
      refreshController.loadFailed();
    }, page);
  }

  Widget buildItemView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 200,
        color: Colors.transparent,
        child: buildBannerWidget(),
      );
    }
    ArticleBean item = articleList[index - 1];
    return ItemArticleList(item: item);
  }

  /// 构建轮播视图
  Widget buildBannerWidget() {
    return Offstage(
      offstage: bannerList.length == 0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index >= bannerList.length ||
              bannerList[index] == null ||
              bannerList[index].imagePath == null) {
            return Container(
              height: 0,
            );
          } else {
            return InkWell(
              child: Container(
                child: CustomCachedImage(imageUrl: bannerList[index].imagePath),
              ),
              onTap: () {},
            );
          }
        },
        itemCount: bannerList.length,
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
