import 'dart:convert';

import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;

  CartRepository({required this.sharedPreferences});
  List<String> cart = [];
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList("cart-list", cart);
    print(sharedPreferences.getStringList("cart-list"));
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];
    return cartList;
  }
}
