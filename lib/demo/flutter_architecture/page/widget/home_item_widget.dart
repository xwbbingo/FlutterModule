import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bean/home_item_bean.dart';
import 'package:start_app/demo/flutter_architecture/common/image_path.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/demo/flutter_architecture/commonui/widget/label_icon.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';
import 'package:start_app/utils/text_util.dart';

class HomeItemWidget extends StatelessWidget {
  final HomeItem model;

  const HomeItemWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
//        if (model.type == 1) {
//          NavigatorUtil.goReposDetail(context, model.name, model.repo);
//        } else if (model.type == 2) {
//          NavigatorUtil.goWebView(context, model.title, model.url);
//        } else if (model.type == 3) {
//          NavigatorUtil.goFlutterHot(context);
//        } else if (model.type == 4) {
//          NavigatorUtil.goUserProfile(context, model.name, "", "");
//        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Row(
              children: <Widget>[
                _buildLeft(),
                _buildRight(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildLeft() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            model.title ?? '--',
            style: YZStyle.middleTextBold,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            TextUtil.isEmpty(model.subTitle) ? '暂无描述' : model.subTitle,
            style: YZStyle.smallTextT65,
          ),
        ),
        _actionColumn(),
      ],
    ));
  }

  _buildRight() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ImageUtil.getNetworkImageBySize(
            model.image, 64, ImagePath.image_default_head),
      );

  _actionColumn() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        LabelIcon(
          label: model.tag,
          image: ImagePath.image_issue_label,
        )
      ],
    );
  }
}
