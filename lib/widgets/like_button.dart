import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  bool isLike = false;
  Function onClick;

  LikeButton({Key key, this.isLike, this.onClick}) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double size = 24.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    animation = Tween(begin: size, end: size * 0.5).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: LikeAnimation(
        controller: controller,
        animation: animation,
        isLike: widget.isLike,
        onClick: widget.onClick,
      ),
    );
  }
}

class LikeAnimation extends AnimatedWidget{
  AnimationController controller;
  Animation animation;
  Function onClick;
  bool isLike = false;

  LikeAnimation({this.controller, this.animation, this.isLike, this.onClick})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        isLike ? Icons.favorite : Icons.favorite_border,
        size: animation.value,
        color: isLike ? Colors.red : Colors.grey[600],
      ),
      onTapDown: (dragDownDetails) {
        controller.forward();
      },
      onTapUp: (dragDownDetails) {
        Future.delayed(Duration(milliseconds: 100), () {
          controller.reverse();
          onClick();
        });
      },
    );
  }
}
