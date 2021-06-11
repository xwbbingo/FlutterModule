import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_app/demo/flutter_architecture/bean/repos_bean.dart';
import 'package:start_app/demo/flutter_architecture/http/api.dart';
import 'package:start_app/demo/flutter_architecture/http/http_request.dart';
import 'package:start_app/demo/flutter_architecture/util/repos_util.dart';
import 'package:start_app/utils/color_util.dart';
import 'package:start_app/utils/text_util.dart';

class ReposManager {
  factory ReposManager() => _getInstance();

  static ReposManager get instance => _getInstance();
  static ReposManager _instance;

  static ReposManager _getInstance() {
    if (_instance == null) {
      _instance = ReposManager._internal();
    }
    return _instance;
  }

  ReposManager._internal();

  Map<String, Color> _languageMap = new Map();

  void initLanguageColors() {
    rootBundle.loadString('assets/data/language_colors.json').then((value) {
      Map map = json.decode(value);
      map.forEach((key, value) {
        String color = value['color'];
        if (!TextUtil.isEmpty(color)) {
          _languageMap.putIfAbsent(key, () => ColorUtil.str2Color(color));
        }
      });
    });
  }

  Color getLanguageColor(String language) {
    return _languageMap[language] ?? Colors.black;
  }

  Future<List<Repository>> getRepos(int page, String sort) async {
    String url = Api.repos(sort);
    url += Api.getPageParams("&", page);
    final response = await HttpRequest().get(url);
    if (response != null && response.result) {
      List<Repository> list = new List();
      if (response.data != null && response.data.length > 0) {
        for (int i = 0; i < response.data.length; i++) {
          var dataItem = response.data[i];
          Repository repository = Repository.fromJson(dataItem);
          repository.description =
              ReposUtil.getGitHubEmojHtml(repository.description ?? "暂无描述");
          list.add(repository);
        }
      }
    }
    return null;
  }
}
