import 'package:flutter/material.dart';
import 'package:start_app/model/food_model.dart';

class CartModel {
  Food food;
  int quantity;

  CartModel({this.food, this.quantity});
}

class Cart extends ChangeNotifier {
  List<CartModel> items = [];

  List<CartModel> get cartItems => items;

  /// 增加
  void addItem(CartModel cartModel) {
    for (CartModel cart in cartItems) {
      if (cartModel.food.name == cart.food.name) {
        cartItems[cartItems.indexOf(cart)].quantity++;
        notifyListeners();
        return;
      }
    }
    items.add(cartModel);
    notifyListeners();
  }

  ///移除
  void removeItem(CartModel cartModel) {
    if (cartItems[cartItems.indexOf(cartModel)].quantity <= 1) {
      return;
    }
    cartItems[cartItems.indexOf(cartModel)].quantity--;
    notifyListeners();
  }

  void increaseItem(CartModel cartModel) {
    cartItems[cartItems.indexOf(cartModel)].quantity++;
    notifyListeners();
  }

  ///清空
  void clearCart() {
    items.clear();
    notifyListeners();
  }

  void removeAllInList(Food food) {
    cartItems.removeWhere((f) => f.food.name == food.name);
    notifyListeners();
  }
}
