import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:start_app/common/common.dart';
import 'package:start_app/model/model_index.dart';
import 'package:start_app/net/api/apis_service.dart';
import 'package:start_app/utils/toast_util.dart';

import 'base_widget.dart';

///公众号
class WeChatScreen extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> attachState() {
    return _WeChatScreenState();
  }
}

class _WeChatScreenState extends BaseWidgetState<WeChatScreen>
    with TickerProviderStateMixin {
  List<WXChaptersBean> _chaptersList = <WXChaptersBean>[];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showLoading().then((value) {
      getWXChaptersList();
    });
  }

  Future getWXChaptersList() async {
    apisService.getWXChaptersList((WXChaptersModel wxChaptersModel) {
      if (wxChaptersModel.errorCode == Constants.STATUS_SUCCESS) {
        if (wxChaptersModel.data.length > 0) {
          showContent();
          setState(() {
            _chaptersList.clear();
            _chaptersList.addAll(wxChaptersModel.data);
          });
        } else {
          showEmpty();
        }
      } else {
        showError();
        ToastUtil.show(msg: wxChaptersModel.errorMsg);
      }
    }, (DioError error) {
      showError();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  AppBar attachAppBar() {
    return AppBar(title: Text(""));
  }

  @override
  Widget attachContentWidget(BuildContext context) {
    _tabController = TabController(length: _chaptersList.length, vsync: this);
  }

  @override
  void onClickErrorWidget() {
    showLoading().then((value) {
      getWXChaptersList();
    });
  }
}
