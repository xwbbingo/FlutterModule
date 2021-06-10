import 'package:flutter/cupertino.dart';
import 'package:start_app/demo/flutter_architecture/bean/repos_bean.dart';
import 'package:start_app/demo/flutter_architecture/common/config.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_list_bloc.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';

abstract class RepoBloc extends BaseListBloc<Repository> {
  static final String TAG = "ReposBloc";

  final String userName;

  RepoBloc(this.userName);

  fetchRepos(int page);

  void initData(BuildContext context) {
    onReload();
  }

  @override
  void onReload() async {
    showLoading();
    await _fetchReposList();
    hideLoading();
  }

  @override
  Future getData() async {
    await _fetchReposList();
  }

  Future _fetchReposList() async {
    LogUtil.v('_fetchReposList', tag: TAG);
    try {
      var result = await fetchRepos(page);
      if (bean.data == null) {
        bean.data = List();
      }
      //刷新时清空下数据
      if (page == 1) {
        bean.data.clear();
      }
      noMore = true;
      if (result != null) {
        bean.isError = false;
        noMore = result.length != Config.PAGE_SIZE;
        bean.data.addAll(result);
      } else {
        if (bean.data.length > 0) {
          bean.isError = false;
          noMore = false;
        } else {
          bean.isError = true;
        }
        if (page > 1) {
          page--;
        }
      }
    } catch (_) {
      if (page > 1) {
        page--;
      }
    }
  }
}
