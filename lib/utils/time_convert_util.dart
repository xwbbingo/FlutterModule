class TimeConvertUtil {
  ///补零
  static String zeroFill(int i) {
    return i >= 10 ? "$i" : "0$i";
  }

  /// 秒转时分秒
  static String second2HMS(int sec, {bool isEasy = true}) {
    String hms = "00:00:00";
    if (!isEasy) hms = "00时00分00秒";
    if (sec > 0) {
      int h = sec ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = "${zeroFill(h)}:${zeroFill(m)}:${zeroFill(s)}";
      if (!isEasy) hms = "${zeroFill(h)}时${zeroFill(m)}分${zeroFill(s)}秒";
    }
    return hms;
  }

  /// 秒转天时分秒
  static String second2DHMS(int sec) {
    String hms = "00天00时00分00秒";
    if (sec > 0) {
      int d = sec ~/ 86400;
      int h = (sec % 86400) ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = "${zeroFill(d)}天${zeroFill(h)}时${zeroFill(m)}分${zeroFill(s)}秒";
    }
    return hms;
  }

  /// 秒转天时分秒
  /// 补零列表长度4，0-日(00) 1-时(00) 2-分(00) 3-秒(00)
  static List<String> second2ListStr(int sec) {
    List<String> list = List(4);
    if (sec > 0) {
      list[0] = zeroFill(sec ~/ 86400); //日
      list[1] = zeroFill((sec % 86400) ~/ 3600); //时
      list[2] = zeroFill((sec % 3600) ~/ 60); //分
      list[3] = zeroFill(sec % 60); //秒
    } else {
      for (int i = 0; i < list.length; i++) list[i] = "00";
    }
    return list;
  }

  /// 秒转天时分秒
  /// 列表长度4，0-日 1-时 2-分 3-秒
  static List<int> second2List(int sec) {
    List<int> list = List(4);
    if (sec > 0) {
      list[0] = sec ~/ 86400; //日
      list[1] = (sec % 86400) ~/ 3600; //时
      list[2] = (sec % 3600) ~/ 60; //分
      list[3] = sec % 60; //秒
    } else {
      for (int i = 0; i < list.length; i++) list[i] = 0;
    }
    return list;
  }
}
