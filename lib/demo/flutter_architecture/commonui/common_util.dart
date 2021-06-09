import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/utils/screen_util.dart';

class CommonUtil {
  static Widget getRedPoint() {
    return Badge(
      elevation: 0,
    );
  }

  static AppBar getAppBar(String title, {List<Widget> actions}) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: YZStyle.normalTextWhite,
      ),
      actions: actions,
    );
  }

  static Widget getLoading(BuildContext context, bool isLoading) {
    return Offstage(
      offstage: !isLoading,
      child: Container(
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp,
        color: Colors.black54,
        child: Center(
          child: SpinKitCircle(
            color: Theme.of(context).primaryColor,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
