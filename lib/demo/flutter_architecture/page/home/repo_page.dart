import 'package:flutter/src/widgets/framework.dart';
import 'package:start_app/demo/flutter_architecture/bean/repos_bean.dart';
import 'package:start_app/demo/flutter_architecture/bloc/repo_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_list_stateless_widget.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/bloc_provider.dart';
import 'package:start_app/demo/flutter_architecture/page/widget/repos_item_widget.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';

class RepoPage extends BaseListStatelessWidget<Repository, RepoBloc> {
  static final String TAG = "ReposPage";

  static final int PAGE_HOME = 0;
  static final int PAGE_USER = 1;
  static final int PAGE_USER_STAR = 2;
  static final int PAGE_ORG = 3;
  static final int PAGE_TOPIC = 4;

  final int page;

  RepoPage(this.page);

  @override
  bool isNeedScaffold() =>
      page != PAGE_HOME &&
      page != PAGE_USER &&
      page != PAGE_USER_STAR &&
      page != PAGE_ORG;

  @override
  String getTitle(BuildContext context) {
    String title;

    if (page == PAGE_TOPIC) {
      RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
      title = bloc.userName;
    } else {
      title = '项目';
    }
    return title;
  }

  @override
  bool isShowAppBarActions() {
    return page != PAGE_ORG;
  }

  @override
  void openWebView(BuildContext context) {
    RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
    String url;
    if (page == PAGE_USER) {
      url = 'https://github.com/${bloc.userName}?tab=repositories';
    } else if (page == PAGE_TOPIC) {
      url = 'https://github.com/topics/${bloc.userName}';
    } else {
      url = 'https://github.com/${bloc.userName}?tab=stars';
    }
    NavigatorUtil.goWebView(context, bloc.userName, url);
  }

  @override
  String getShareText(BuildContext context) {
    RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
    String url;
    if (page == PAGE_USER) {
      url = 'https://github.com/${bloc.userName}?tab=repositories';
    } else if (page == PAGE_TOPIC) {
      url = 'https://github.com/topics/${bloc.userName}';
    } else {
      url = 'https://github.com/${bloc.userName}?tab=stars';
    }
    return url;
  }

  @override
  Widget builderItem(BuildContext context, Repository item) {
    return ReposItemWidget(item);
  }
}
