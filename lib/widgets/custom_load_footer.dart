import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomLoadFooter extends CustomFooter {
  @override
  double get height => 40;

  @override
  FooterBuilder get builder => (context, mode) {
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
      };
}
