import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'counter_easy_logic.dart';

class CounterEasyPage extends StatelessWidget {
  final logic = Get.put(CounterEasyLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('计数器'),
      ),
      body: Center(
        child: GetBuilder<CounterEasyLogic>(builder: (logic) {
          return Text('点击了${logic.count}');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.increase(),
        child: Icon(Icons.add),
      ),
    );
  }
}
