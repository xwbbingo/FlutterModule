import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:start_app/utils/screen_util.dart';

class CommonUtil {
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
