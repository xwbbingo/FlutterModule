import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_app/demo/flutter_cart/model/cart_model.dart';
import 'package:start_app/demo/flutter_cart/page/cart_page.dart';

void main() {
  runApp(CartApp());
}

class CartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        title: 'Flutter Food',
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CartPage(),
      ),
    );
  }
}
