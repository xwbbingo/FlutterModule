import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_cn/widget/random_words.dart';
import 'package:start_app/widgets/drop_down_menu/drop_down_filter_widget.dart';

void main() {
  runApp(new MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: DropDownFilterWidget(),
    //home: CustomScrollViewRoute(),
  ));
}

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
//          //child: new Text('Hello World'),
//          //child: new Text(wordPair.asPascalCase),
//          child: new RandomWords(),
//        ),
//      ),
    );
  }
}
