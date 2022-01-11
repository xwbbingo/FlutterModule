//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//
//typedef OnRefresh = void Function();
//typedef OnLoadMore = void Function();
//typedef FilterCondition = void Function(String sortKey, String sortType);
//
/////商品筛选页面
//class SimpleShopFilterWidget extends StatefulWidget {
//  //列表模式或表格模式
//  final bool isList;
//
//  final OnRefresh onRefresh;
//  final OnLoadMore onLoadMore;
//  final FilterCondition filterCondition;
//
//  //侧边筛选控件回调
//  final VoidCallback onTapFilter;
//
//  const SimpleShopFilterWidget(
//      {Key key,
//      this.isList = false,
//      this.onRefresh,
//      this.onLoadMore,
//      this.filterCondition,
//      this.onTapFilter})
//      : super(key: key);
//
//  @override
//  _SimpleShopFilterWidgetState createState() => _SimpleShopFilterWidgetState();
//}
//
//class _SimpleShopFilterWidgetState extends State<SimpleShopFilterWidget> {
//  //展示形式
//  bool _isList;
//
//  RefreshController _refreshController =
//      RefreshController(initialRefresh: false);
//
//  ScrollController _scrollController = new ScrollController();
//
//  //列表数据
//  List<Content> listData = <Content>[];
//
//  List<String> _dropDownHeaderItems = ['综合', '销量', '价格'];
//
////  DropDownHeaderItem _downHeaderItem;
//
////  bool needSort = false;
//
//  GlobalKey _stackKey = GlobalKey();
//
//  //方法1 查找父级最近的Scaffold对应的ScaffoldState对象
//  //ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
//  //方法2 直接通过of静态方法来获取ScaffoldState
//  //  ScaffoldState _state=Scaffold.of(context);
//
//  @override
//  void initState() {
//    super.initState();
//    _isList = widget.isList;
//    //1.根据关键字，再配合筛选的默认条件去请求数据
//    listData.clear();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _scrollController.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
////      backgroundColor: Colors.blue,
//      body: Stack(
//        key: _stackKey,
//        children: [
//          Column(
//            children: <Widget>[
//              Row(
//                children: [
//                  Expanded(
//                    child: SimpleDropDownHeader(
//                      stackKey: _stackKey,
//                      items: [
//                        DropDownHeaderItem(_dropDownHeaderItems[0],
//                            isShowIcon: false),
//                        DropDownHeaderItem(_dropDownHeaderItems[1],
//                            isShowIcon: false),
//                        DropDownHeaderItem(
//                          _dropDownHeaderItems[2],
//                          isShowIcon: true,
//                          iconDefaultData: KMImage.icon_drop_default,
//                          iconDropDownData: KMImage.icon_drop_down,
//                          iconDropUpData: KMImage.icon_drop_up,
//                        ),
//                      ],
//                      //点击某个item
//                      onItemTap: (item, index) {
//                        String sortKey = '';
//                        String sortType = '';
//                        if (index == 2) {
////                          needSort = true;
////                          _downHeaderItem = item;
//                          sortKey = SortKey.maxPrice;
//                          sortType = item.asc ? SortType.asc : SortType.desc;
//                        } else if (index == 1) {
////                          needSort = false;
////                          _downHeaderItem = null;
//                          sortKey = SortKey.browseCount;
//                          sortType = SortType.desc;
//                        } else {}
//                        if (widget.filterCondition != null) {
//                          widget.filterCondition(sortKey, sortType);
//                        }
//                        //点击事件
//                        //点击下标1或2,重置下标0的值
////                        if (index == 1 || index == 2) {
////                          //将所有置为未选中状态
////                          for (var value in _oneItems) {
////                            value.isSelected = false;
////                          }
////                          _dropDownHeaderItems[0] = _oneItems[0].name;
////                          _dropdownMenuController.updateSelectIndex(index);
////                          setState(() {});
////                        }
//                      },
////                      headerHeight: 60,
//                    ),
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      setState(() {
//                        _isList = !_isList;
//                      });
//                    },
//                    child: Container(
////                      color: Colors.red,
//                      width: 40,
//                      height: 40,
//                      child: Icon(_isList ? Icons.list : Icons.grid_view),
//                    ),
//                  ),
//                ],
//              ),
//              //此处放置列表页
//              Expanded(
//                child: BlocBuilder<StoreShopBloc, StoreShopState>(
//                  builder: (context, state) {
////                    LogUtil.v("商品页：" + state.toString(), tag: 'xwb');
//                    if (state is StoreShopEmpty) {
//                      return StatusViews(
//                        KMLoadStatus.empty,
//                        nonebutton: false,
//                      );
//                    }
//                    if (state is StoreShopSuccess) {
//                      if (!state.isLoadMore) {
//                        _scrollController.animateTo(.0,
//                            duration: Duration(milliseconds: 200),
//                            curve: Curves.ease);
//                        //下拉刷新
//                        listData.clear();
//                        _refreshController?.refreshCompleted(
//                            resetFooterState: true);
//                        if (state.last) {
//                          //刚好一页
//                          _refreshController?.loadNoData();
//                        }
//                      } else {
//                        //上拉加载
//                        if (state.last) {
//                          //没有更多了
//                          _refreshController?.loadNoData();
//                        } else {
//                          //加载更多完成
//                          _refreshController?.loadComplete();
//                        }
//                      }
//                      listData.addAll(state.contents);
////                      if (needSort && _downHeaderItem != null) {
////                        //升序或降序
////                      }
//                      return SmartRefresher(
//                        enablePullDown: true,
//                        enablePullUp: true,
//                        controller: _refreshController,
//                        onRefresh: () async {
//                          widget?.onRefresh();
//                        },
//                        onLoading: () async {
//                          widget?.onLoadMore();
//                        },
//                        child:
////                        resultWidget,
//                            buildShopFilterType(),
//                      );
//                    }
//                    if (state is StoreShopFailure) {
//                      return Container();
//                    }
//                    return Container();
//                  },
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  //商品以哪种形式展示
//  Widget buildShopFilterType() {
//    return _isList
//        ? ListView.builder(
////          shrinkWrap: true,
//            controller: _scrollController,
//            itemCount: listData.length,
//            physics: AlwaysScrollableScrollPhysics(),
//            itemBuilder: (context, index) {
//              return FilterGoodsItemWidget(
//                listData[index],
//                isList: true,
//                onItemTap: (value) {
//                  Routes.navigateToSn(
//                      context, value?.data?.sn, Routes.ACTION_TYPE_GOODS);
//                },
//              );
//            })
//        : GridView.builder(
////          shrinkWrap: true,
//            controller: _scrollController,
//            itemCount: listData.length,
//            physics: AlwaysScrollableScrollPhysics(),
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              childAspectRatio: 6 / 10,
//              crossAxisCount: 2,
//              mainAxisSpacing: 10,
//              crossAxisSpacing: 6,
//            ),
//            itemBuilder: (context, index) {
//              return FilterGoodsItemWidget(
//                listData[index],
//                isList: false,
//                onItemTap: (value) {
//                  Routes.navigateToSn(
//                      context, value?.data?.sn, Routes.ACTION_TYPE_GOODS);
//                },
//              );
//            });
//  }
//}
