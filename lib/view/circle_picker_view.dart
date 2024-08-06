import 'package:flutter/material.dart';
import 'dart:math' as Math;

class CircularDialProgress extends StatefulWidget {
  @override
  _CircularDialProgressState createState() => _CircularDialProgressState();
}

class _CircularDialProgressState extends State<CircularDialProgress> {
  double _angle = 0; // 指针的角度
  double _progress = 0; // 进度值，以百分比表示
  double _radius = 150.0; // 圆的半径
  Offset _center; // 圆的中心

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _center = Offset(300 / 2, 300 / 2);
      return GestureDetector(
        onPanUpdate: (details) {
          // 根据拖动的距离计算角度变化
          double deltaX =  details.localPosition.dx - _center.dx;//details.delta.dx;
          double deltaY = details.localPosition.dy - _center.dy;//details.delta.dy;
          double angleDelta = Math.atan2(deltaY, deltaX);

          // 计算触摸点与圆心的距离
          double dx = details.localPosition.dx - _center.dx;
          double dy = details.localPosition.dy - _center.dy;
          double distance = Math.sqrt(dx * dx + dy * dy);
          print('当前角度${deltaX} ${deltaY} ${angleDelta}   ${details.localPosition}  $distance $dx $dy');
          // 计算进度值
          double progress = distance / _radius;
          progress = Math.min(1.0, Math.max(0.0, progress)); // 限制在0到1之间

          setState(() {
            _angle = Math.atan2(deltaY, deltaX) * (180 / Math.pi);
            // _angle = (_angle + angleDelta) % (2 * Math.pi);
            print('当前角度${_angle}');
            print('当前进度值${progress}');
            // 将角度转换为进度值
            _progress = progress;
          });
        },
        child: Stack(
          children: [
            // 绘制圆形表盘和指针
            CustomPaint(
              painter: DialPainter(_center, _radius, _angle),
              size: Size(400, 400),
            ),
            // 显示进度文本
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '${(_progress * 100).round()}%', // 显示进度百分比，保留0位小数
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class DialPainter extends CustomPainter {
  final Offset center;
  final double radius;
  final double angle;

  DialPainter(this.center, this.radius, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制圆形表盘背景
    Paint circlePaint = Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    // 绘制指针
    Paint pointerPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    // double pointerLength = radius - 10;
    // Offset pointerEnd = Offset(
    //   center.dx + Math.cos(angle) * pointerLength,
    //   center.dy + Math.sin(angle) * pointerLength,
    // );
    // canvas.drawLine(center, pointerEnd, pointerPaint);

    Path hourPath = Path();
    hourPath.moveTo(center.dx, center.dy);
    double hourLength = radius * 0.6; // 小时指针长度
    double hourX = center.dx + hourLength * Math.cos(angle);
    double hourY = center.dy + hourLength * Math.sin(angle);
    hourPath.lineTo(hourX, hourY);
    canvas.drawPath(hourPath, pointerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}