import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_app/model/cart_model.dart';
import 'package:start_app/model/food_model.dart';
import 'package:start_app/res/colors.dart';
import 'package:start_app/widgets/cart_bottom_sheet.dart';
import 'package:start_app/widgets/food_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            buildAppBar(),
            buildFoodFilter(),
            buildFoodList(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    int items = 0;
    Provider.of<Cart>(context).cartItems.forEach((cart) {
      items = items + cart.quantity;
    });
    return SafeArea(
        child: Row(
      children: <Widget>[
        Text(
          'MENU',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        Stack(
          children: <Widget>[
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: showCart),
            Positioned(
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: mainColor),
                child: Text(
                  '$items',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }

  Widget buildFoodFilter() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: List.generate(foodTypes.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ChoiceChip(
              selectedColor: mainColor,
              selected: value == index,
              labelStyle: TextStyle(
                  color: value == index ? Colors.white : Colors.black),
              label: Text(foodTypes[index]),
              onSelected: (selected) {
                setState(() {
                  value = selected ? index : null;
                });
              },
            ),
          );
        }),
      ),
    );
  }

  Widget buildFoodList() {
    return Expanded(
      child: GridView.builder(
          itemCount: foods.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 6,
              mainAxisSpacing: 12,
              crossAxisSpacing: 16),
          itemBuilder: (context, index) {
            return FoodCard(foods[index]);
          }),
    );
  }

  ///展示购物车
  showCart() {
    showModalBottomSheet(
        shape: roundedRectangle32,
        context: context,
        builder: (context) {
          return CartBottomSheet();
        });
  }
}
