import 'dart:math';

import 'package:flutter/material.dart';
import 'package:start_app/utils/theme_util.dart';

Color mainColor = Color.fromRGBO(255, 204, 0, 1);

class MyColors {
  static const Color app_main = Color(0xFF666666);
  static const Color app_bg = Color(0xfff5f5f5);

  static const Color transparent = Color(0x00000000);

  static const Color transparent_80 = Color(0x80000000); //<!--204-->
  static const Color white_19 = Color(0X19FFFFFF);
  static const Color transparent_ba = Color(0xBA000000);

  static const Color text_dark = Color(0xFF333333);
  static const Color text_normal = Color(0xFF666666);
  static const Color text_gray = Color(0xFF999999);

  static const Color divider = Color(0xffe5e5e5);

  static const Color gray_33 = Color(0xFF333333); //51
  static const Color gray_66 = Color(0xFF666666); //102
  static const Color gray_99 = Color(0xFF999999); //153
  static const Color common_orange = Color(0XFFFC9153); //252 145 83
  static const Color gray_ef = Color(0XFFEFEFEF); //153

  static const Color gray_f0 = Color(0xfff0f0f0); //<!--204-->
  static const Color gray_f5 = Color(0xfff5f5f5); //<!--204-->
  static const Color gray_cc = Color(0xffcccccc); //<!--204-->
  static const Color gray_ce = Color(0xffcecece); //<!--206-->
  static const Color green_1 = Color(0xff009688); //<!--204-->
  static const Color green_62 = Color(0xff626262); //<!--204-->
  static const Color green_e5 = Color(0xffe5e5e5); //<!--204-->

  static const Color green_de = Color(0xffdedede);

  static const Color tag_bg = Color(0xFFF44336);

  static const Color color_FFFFFF = Color(0xFFFFFFFF);

  static const Color color_333333 = Color(0xFF333333);
  static const Color color_666666 = Color(0xFF666666);
  static const Color color_999999 = Color(0xFF999999);

  /// 随机获取颜色
  static Color randomColor() {
    Random random = Random();
    int r = 0;
    int g = 0;
    int b = 0;
    bool dark = ThemeUtil.dark; // 是否是夜间模式
    if (!dark) {
      // 0-190, 如果颜色值过大,就越接近白色,就看不清了,所以需要限定范围
      r = random.nextInt(190);
      g = random.nextInt(190);
      b = random.nextInt(190);
    } else {
      // 150-255
      r = random.nextInt(105) + 150;
      g = random.nextInt(105) + 150;
      b = random.nextInt(105) + 150;
    }
    return Color.fromARGB(255, r, g, b);
  }
}

Map<String, Color> circleAvatarMap = {
  'A': Colors.blueAccent,
  'B': Colors.blue,
  'C': Colors.cyan,
  'D': Colors.deepPurple,
  'E': Colors.deepPurpleAccent,
  'F': Colors.blue,
  'G': Colors.green,
  'H': Colors.lightBlue,
  'I': Colors.indigo,
  'J': Colors.blue,
  'K': Colors.blue,
  'L': Colors.lightGreen,
  'M': Colors.blue,
  'N': Colors.brown,
  'O': Colors.orange,
  'P': Colors.purple,
  'Q': Colors.black,
  'R': Colors.red,
  'S': Colors.blue,
  'T': Colors.teal,
  'U': Colors.purpleAccent,
  'V': Colors.black,
  'W': Colors.brown,
  'X': Colors.blue,
  'Y': Colors.yellow,
  'Z': Colors.grey,
  '#': Colors.blue,
};

Map<String, Color> themeColorMap = {
  'redAccent': Colors.redAccent,
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.deepPurple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.deepOrange,
  'green': Colors.green,
  'lime': Colors.lime,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'amber': Colors.amber,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'cyan': Colors.cyan,
  'teal': Colors.teal,
  'black': Colors.black,
};
