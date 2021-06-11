import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/bean/repos_bean.dart';
import 'package:start_app/demo/flutter_architecture/common/image_path.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/demo/flutter_architecture/commonui/widget/label_icon.dart';
import 'package:start_app/demo/flutter_architecture/manager/repos_manager.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';

class ReposItemWidget extends StatelessWidget {
  final Repository item;

  ReposItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _postCard(context),
      ),
      onTap: () {
//        NavigatorUtil.goReposDetail(context, item.owner.login, item.name);
      },
    );
  }

  _postCard(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _profileColumn(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.name ?? "--",
              style: YZStyle.middleTextBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.description ?? '',
              style: YZStyle.smallTextT65,
            ),
          ),
          _actionRow(),
        ],
      ),
    );
  }

  _profileColumn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ImageUtil.getCircleNetworkImage(
            item.owner.avatarUrl, 36.0, ImagePath.image_default_head),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              item.owner.login,
              style: YZStyle.smallText,
            ),
          ),
        ),
        ClipOval(
          child: Container(
            color: ReposManager.instance.getLanguageColor(item.language),
            width: 8.0,
            height: 8.0,
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          item.language ?? 'Unkown',
          style: YZStyle.smallSubText,
        ),
      ],
    );
  }

  _actionRow() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        LabelIcon(
          label: item.stargazersCount.toString(),
          image: ImagePath.image_star,
        ),
        LabelIcon(
          label: item.openIssuesCount.toString(),
          image: ImagePath.image_issue,
        ),
        LabelIcon(
          label: item.forksCount.toString(),
          image: ImagePath.image_fork,
        )
      ],
    );
  }
}
