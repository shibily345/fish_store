import 'dart:convert';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;

  CartRepository({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];
  Future<void> addToCartList(List<CartModel> cartList) async {
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    await sharedPreferences.setStringList(AppConstents.Cart_list, cart);
    print(sharedPreferences.getStringList(AppConstents.Cart_list));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstents.Cart_list)) {
      carts = sharedPreferences.getStringList(AppConstents.Cart_list)!;
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstents.Cart_history_list)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstents.Cart_history_list)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    print(
        "saved list....................'''''''''''''''''''''''''''''''''''''''''''''''''''''''" +
            cartListHistory.toString());
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstents.Cart_history_list)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstents.Cart_history_list)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
      print(
          cart[i] + '................................... itemssssssssssadded');
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstents.Cart_history_list, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstents.Cart_list);
  }
}
