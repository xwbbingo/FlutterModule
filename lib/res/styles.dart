import 'package:flutter/material.dart';
import 'package:start_app/res/dimens.dart';
import 'package:start_app/utils/theme_util.dart';

class Decorations {
  static Decoration bottom = new BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 0.5,
        color: ThemeUtil.getThemeData().dividerColor,
      ),
    ),
  );
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: MyDimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: MyDimens.gap_dp10);
  static Widget hGap15 = new SizedBox(width: MyDimens.gap_dp15);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: MyDimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: MyDimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: MyDimens.gap_dp15);
}
