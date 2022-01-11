import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/demo/flutter_architecture/localizations/app_localizations.dart';
import 'package:start_app/demo/flutter_architecture/route/navigator_util.dart';
import 'package:start_app/demo/flutter_architecture/util/common_util.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonUtil.getAppBar(
          AppLocalizations.of(context).currentlocal.setting),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.color_lens,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(AppLocalizations.of(context).currentlocal.theme,
                style: YZStyle.middleText),
            trailing: Icon(
              Icons.navigate_next,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              NavigatorUtil.goTheme(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(AppLocalizations.of(context).currentlocal.language,
                style: YZStyle.middleText),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              NavigatorUtil.goLanguage(context);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.cached),
          //   title: Text(AppLocalizations.of(context).currentlocal.cache,
          //       style: YZStyle.middleText),
          //   trailing: Icon(Icons.navigate_next),
          //   onTap: () {
          //     NavigatorUtil.goCache(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
