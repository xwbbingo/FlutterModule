import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new CounterIncrementor(onPressed: _increment,),
        new CounterDisplay(count: _counter,),
//        new RaisedButton(
//          onPressed: _increment,
//          child: new Text('Increment'),
//        ),
//        new Text('Count: $_counter'),
      ],
    );
  }

  void _increment() {
    setState(() {
      _counter++;
    });
  }
}

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}
