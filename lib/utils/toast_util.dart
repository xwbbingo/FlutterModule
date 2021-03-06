import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:start_app/res/my_colors.dart';

/// Toast 简单封装
class ToastUtil {
  ///Toast with No Build Context (Android & iOS)
  static show({
    @required String msg,
    Toast toastLength = Toast.LENGTH_SHORT,
    int timeInSecForIos = 1,
    double fontSize = 16.0,
    ToastGravity gravity,
    Color backgroundColor = MyColors.transparent_ba,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      timeInSecForIosWeb: timeInSecForIos,
      fontSize: fontSize,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static cancel() {
    Fluttertoast.cancel();
  }

  static void showMessgae(String message) {
    ToastBuilder builder = ToastBuilder();
    builder.msg(message);
    _showBuilder(builder);
  }

  static void _showBuilder(ToastBuilder builder) {
    Fluttertoast.showToast(
        msg: builder.getMsg(),
        toastLength: builder.getToastLength(),
        gravity: builder.getGravity(),
        timeInSecForIosWeb: builder.getTimeInSecForIos(),
        backgroundColor: builder.getBackgroundColor(),
        textColor: builder.getTextColor(),
        fontSize: builder.getFontSize());
  }
}

class ToastBuilder {
  String _msg;
  Toast _toastLength = Toast.LENGTH_SHORT;
  int _timeInSecForIos = 1;
  double _fontSize = 14.0;
  ToastGravity _gravity = ToastGravity.BOTTOM;
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white;

  ToastBuilder msg(String msg) {
    this._msg = msg;
  }

  ToastBuilder length(Toast toastLength) {
    this._toastLength = toastLength;
  }

  ToastBuilder timeInSecForIos(int timeInSecForIos) {
    this._timeInSecForIos = timeInSecForIos;
  }

  ToastBuilder fontSize(double fontSize) {
    this._fontSize = fontSize;
  }

  ToastBuilder gravity(ToastGravity gravity) {
    this._gravity = gravity;
  }

  ToastBuilder backgroundColor(Color backgroundColor) {
    this._backgroundColor = backgroundColor;
  }

  ToastBuilder textColor(Color textColor) {
    this._textColor = textColor;
  }

  String getMsg() {
    return _msg;
  }

  Toast getToastLength() {
    return _toastLength;
  }

  int getTimeInSecForIos() {
    return _timeInSecForIos;
  }

  double getFontSize() {
    return _fontSize;
  }

  ToastGravity getGravity() {
    return _gravity;
  }

  Color getBackgroundColor() {
    return _backgroundColor;
  }

  Color getTextColor() {
    return _textColor;
  }
}
