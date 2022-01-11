import 'dart:async';

import 'package:flutter/material.dart';
import 'package:start_app/utils/time_convert_util.dart';

class TimerCountDownWidget extends StatefulWidget {
  final Function onTimerFinish;
  final int countdownTime;

  const TimerCountDownWidget({Key key, this.onTimerFinish, this.countdownTime})
      : super(key: key);

  @override
  _TimerCountDownWidgetState createState() => _TimerCountDownWidgetState();
}

class _TimerCountDownWidgetState extends State<TimerCountDownWidget> {
  Timer _timer;
  int _countdownTime;

  @override
  void initState() {
    super.initState();

//   过期时间 - DateTime.now().millisecondsSinceEpoch
    _countdownTime = widget.countdownTime;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_countdownTime < 0) {
          //倒计时结束
          if (widget.onTimerFinish != null) {
            widget.onTimerFinish();
          }
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1000;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Text('剩余支付时间 ${TimeConvertUtil.second2HMS(_countdownTime ~/ 1000)}'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
