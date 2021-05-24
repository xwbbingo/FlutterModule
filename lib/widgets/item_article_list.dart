import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:start_app/model/article_model.dart';
import 'package:start_app/res/my_colors.dart';
import 'package:start_app/utils/route_util.dart';
import 'package:start_app/utils/toast_util.dart';
import 'package:start_app/widgets/custom_cached_image.dart';
import 'package:start_app/widgets/like_button.dart';

///文章列表
class ItemArticleList extends StatefulWidget {
  ArticleBean item;

  ItemArticleList({this.item});

  @override
  _ItemArticleListState createState() => _ItemArticleListState();
}

class _ItemArticleListState extends State<ItemArticleList> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    return InkWell(
      onTap: () {
        //跳转文章页
        RouteUtil.toWebView(context, item.title, item.link);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                Offstage(
                  offstage: item.top == 0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.tag_bg, width: 0.5),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(2, 2),
                          bottom: Radius.elliptical(2, 2)),
                    ),
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Text(
                      '置顶',
                      style: TextStyle(
                        fontSize: 10,
                        color: MyColors.tag_bg,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Offstage(
                  offstage: !item.fresh,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.tag_bg, width: 0.5),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(2, 2),
                          bottom: Radius.elliptical(2, 2)),
                    ),
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Text(
                      '新',
                      style: TextStyle(
                        fontSize: 10,
                        color: MyColors.tag_bg,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Offstage(
                  offstage: item.tags.length == 0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan, width: 0.5),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(2, 2),
                          bottom: Radius.elliptical(2, 2)),
                    ),
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Text(
                      item.tags.length > 0 ? item.tags[0].name : "",
                      style: TextStyle(fontSize: 10, color: Colors.cyan),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Text(
                  item.author.isNotEmpty ? item.author : item.shareUser,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                  child: Text(
                    item.niceDate,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Offstage(
                  offstage: item.envelopePic == "",
                  child: Container(
                    width: 100,
                    height: 80,
                    padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                    child: CustomCachedImage(imageUrl: item.envelopePic),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(
                          item.title,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.superChapterName +
                                    " / " +
                                    item.chapterName,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            LikeButton(
                              isLike: item.collect,
                              onClick: () {
                                //收藏或取消
                                ToastUtil.show(msg: "功能待开发");
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
