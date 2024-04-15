import 'dart:convert';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;

  CartRepository({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];
  Future<void> addToCartList(List<CartModel> cartList) async {
    var time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;

      continue;
    }
    print(cart.toString());
    await sharedPreferences.setStringList(AppConstents.Cart_list, cart);
    print(sharedPreferences.getStringList(AppConstents.Cart_list));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstents.Cart_list)) {
      carts = sharedPreferences.getStringList(AppConstents.Cart_list)!;
    }
    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstents.Cart_history_list)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstents.Cart_history_list)!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    print(
        "saved list....................'''''''''''''''''''''''''''''''''''''''''''''''''''''''$cartListHistory");
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstents.Cart_history_list)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstents.Cart_history_list)!;
    }
    for (int i = 0; i < cart.length; i++) {
      // Add the cart item to the cart history list, if it is not already in the list
      if (!cartHistory.contains(cart[i])) {
        cartHistory.add(cart[i]);
        print(
            '${cart[i]}................................... itemssssssssssadded');
      }
    }

    sharedPreferences.setStringList(
        AppConstents.Cart_history_list, cartHistory);
    removeCart();
  }

  Future<void> removeFromCartList(CartModel itemToRemove) async {
    List<String>? cart =
        sharedPreferences.getStringList(AppConstents.Cart_list);

    if (cart != null) {
      cart.removeWhere((element) {
        final decodedItem = jsonDecode(element);
        final cartItem = CartModel.fromJson(decodedItem);

        // Compare the item you want to remove with the item in the list
        return cartItem.id == itemToRemove.id;
      });

      print("-----------------------item removed$itemToRemove");

      await sharedPreferences.setStringList(AppConstents.Cart_list, cart);
      print(sharedPreferences.getStringList(AppConstents.Cart_list));
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstents.Cart_list);
  }

  void clearOrderHistory() {
    removeCart();
    sharedPreferences.remove(AppConstents.Cart_history_list);
  }
}
