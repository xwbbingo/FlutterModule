import 'package:flutter/material.dart';
import 'package:start_app/utils/text_util.dart';

import '../common_style.dart';
import 'side_bar.dart';

const List<String> _list = const [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "#"
];

class SideBar extends StatefulWidget {
  SideBar({
    Key key,
    @required this.onTouch,
    this.width = 30,
    this.letterHeight = 16,
    this.color = Colors.transparent,
    this.textStyle = YZStyle.minSubText,
    this.touchDownColor = const Color(0x40E0E0E0),
    this.touchDownTextStyle = YZStyle.minText,
  });

  final int width;

  final int letterHeight;

  final Color color;

  final Color touchDownColor;

  final TextStyle textStyle;

  final TextStyle touchDownTextStyle;

  final OnTouchingLetterChanged onTouch;

  @override
  _SideBarState createState() {
    return _SideBarState();
  }
}

class _SideBarState extends State<SideBar> {
  bool _isTouchDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: _isTouchDown ? widget.touchDownColor : widget.color,
      width: widget.width.toDouble(),
      child: _SideItemBar(
        letterWidth: widget.width,
        letterHeight: widget.letterHeight,
        textStyle: _isTouchDown ? widget.touchDownTextStyle : widget.textStyle,
        onTouch: (letter) {
          if (widget.onTouch != null) {
            setState(() {
              _isTouchDown = !TextUtil.isEmpty(letter);
            });
            widget.onTouch(letter);
          }
        },
      ),
    );
  }
}

class _SideItemBar extends StatefulWidget {
  final int letterWidth;

  final int letterHeight;

  final TextStyle textStyle;

  final OnTouchingLetterChanged onTouch;

  _SideItemBar(
      {Key key,
      @required this.onTouch,
      this.letterWidth = 30,
      this.letterHeight = 16,
      this.textStyle})
      : assert(onTouch != null),
        super(key: key);

  @override
  _SideItemBarState createState() {
    return _SideItemBarState();
  }
}

class _SideItemBarState extends State<_SideItemBar> {
  List<int> _letterPositionList = List();
  int _widgetTop = -1;
  int _lastIndex = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _style = widget.textStyle;

    List<Widget> children = List();
    _list.forEach((v) {
      children.add(SizedBox(
        width: widget.letterWidth.toDouble(),
        height: widget.letterHeight.toDouble(),
        child: Text(v, textAlign: TextAlign.center, style: _style),
      ));
    });

    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        //???????????????????????????????????????
        if (_widgetTop == -1) {
          RenderBox box = context.findRenderObject();
          Offset topLeftPosition = box.localToGlobal(Offset.zero);
          _widgetTop = topLeftPosition.dy.toInt();
        }
        //??????touch??????????????????????????????
        int offset = details.globalPosition.dy.toInt() - _widgetTop;
        int index = _getIndex(offset);
        //???????????????????????????????????????????????????????????????????????????
        if (index != -1) {
          _lastIndex = index;
          _triggerTouchEvent(_list[index]);
        }
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        //??????touch??????????????????????????????
        int offset = details.globalPosition.dy.toInt() - _widgetTop;
        int index = _getIndex(offset);
        //?????????????????????????????????????????????????????????????????????????????????
        if (index != -1 && _lastIndex != index) {
          _lastIndex = index;
          _triggerTouchEvent(_list[index]);
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {
        _lastIndex = -1;
        _triggerTouchEvent('');
      },
      onTapUp: (TapUpDetails details) {
        _lastIndex = -1;
        _triggerTouchEvent('');
      },
      //??????UI
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  void _init() {
    _letterPositionList.clear();
    _letterPositionList.add(0);
    int tempHeight = 0;
    _list?.forEach((value) {
      tempHeight = tempHeight + widget.letterHeight;
      _letterPositionList.add(tempHeight);
    });
  }

  int _getIndex(int offset) {
    for (int i = 0, length = _letterPositionList.length; i < length - 1; i++) {
      int a = _letterPositionList[i];
      int b = _letterPositionList[i + 1];
      if (offset >= a && offset < b) {
        return i;
      }
    }
    return -1;
  }

  _triggerTouchEvent(String letter) {
    if (widget.onTouch != null) {
      widget.onTouch(letter);
    }
  }
}
