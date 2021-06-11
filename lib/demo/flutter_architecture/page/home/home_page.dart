import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bean/home_banner_bean.dart';
import 'package:start_app/demo/flutter_architecture/bean/home_bean.dart';
import 'package:start_app/demo/flutter_architecture/bean/home_item_bean.dart';
import 'package:start_app/demo/flutter_architecture/bloc/home_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_stateless_widget.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';
import 'package:start_app/demo/flutter_architecture/page/widget/header_item_widget.dart';
import 'package:start_app/demo/flutter_architecture/page/widget/home_item_widget.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';

class HomePage extends BaseStatelessWidget<LoadingBean<HomeBean>, HomeBloc> {
  @override
  bool isShowAppBar(BuildContext buildContext) => false;

  @override
  int getItemCount(LoadingBean<HomeBean> data) {
    return 1;
  }

  @override
  bool isLoading(LoadingBean<HomeBean> data) {
    return data != null ? data.isLoading : true;
  }

  @override
  Widget getChild(BuildContext context, LoadingBean<HomeBean> data) {
    if (data == null ||
        data.data == null ||
        data.data.banner == null ||
        data.data.itemBean == null) {
      return Container();
    }
    return ListView(
      children: [
        _buildBanner(context, data.data.banner),
        _buildItem(context, data.data.itemBean.recommend, Icons.book, "推荐项目"),
        _buildItem(context, data.data.itemBean.other, Icons.language, "其它资源"),
      ],
    );
  }

  _buildBanner(BuildContext context, List<Data> banner) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.topEnd,
        circular: true,
        interval: const Duration(seconds: 3),
        indicator: NumberSwiperIndicator(),
        children: banner.map((model) {
          return InkWell(
            onTap: () {
              NavigatorUtil.goWebView(context, model.title, model.url);
            },
            child: ImageUtil.getNetworkImage(model.imagePath),
          );
        }).toList(),
      ),
    );
  }

  _buildItem(BuildContext context, List<HomeItem> item, IconData leftIcon,
      String title) {
    List<Widget> _children = item.map((model) {
      return HomeItemWidget(model);
    }).toList();
    List<Widget> children = <Widget>[];
    children.add(HeaderItemWidget(
      leftIcon: leftIcon,
      title: title,
    ));
    children.addAll(_children);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      child: Text(
        '${++index}/$itemCount',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
