
import 'dart:math' as Math;
import 'package:flutter/material.dart';

class CircleClock extends StatefulWidget {
  @override
  _CircleClockState createState() => _CircleClockState();
}

class _CircleClockState extends State<CircleClock> {
  Offset _touchPoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _touchPoint = details.localPosition;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _touchPoint = null;
        });
      },
      child: CustomPaint(
        painter: CircleClockPainter(touchPoint: _touchPoint),
        size: Size(100,100),
      ),
    );
  }
}
class CircleClockPainter extends CustomPainter {
  // 触摸点的位置
  Offset touchPoint;

  CircleClockPainter({this.touchPoint});

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    var radius = Math.min(size.width, size.height) / 2;

    // 绘制圆形表盘
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);

    // 如果有触摸点，绘制一条从圆心到触摸点的线
    if (touchPoint != null) {
      Paint linePaint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawLine(center, touchPoint, linePaint);

      // 计算并绘制角度文本
      double angle = calculateAngle(center, touchPoint);
      TextSpan span = TextSpan(
        text: '${angle.toStringAsFixed(2)}°',
        style: TextStyle(color: Colors.black, fontSize: 20),
      );
      TextPainter textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height));
    }
  }

  // 计算两点之间的角度
  double calculateAngle(Offset center, Offset point) {
    double deltaY = point.dy - center.dy;
    double deltaX = point.dx - center.dx;
    return Math.atan2(deltaY, deltaX) * (180 / Math.pi);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

