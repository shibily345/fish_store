import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/presentation/booking/placed_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final CartRepository cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  int _incartItems = 0;
  int get inCartItems => _incartItems;
  List<CartModel> storageItems = [];
  void addItem(
    ProductModel product,
    int totquantity,
    int pairQuantity,
    int maleQuantity,
    int feQuantity,
    double price,
  ) {
    items.putIfAbsent(product.id!, () {
      print(
          ".............items =   $totquantity......................${product.id}..........");
      return CartModel(
        id: product.id,
        name: product.name,
        price: price,
        img: product.img,
        totquantity: totquantity,
        mquantity: maleQuantity,
        fquantity: feQuantity,
        pquantity: pairQuantity,
        isExisted: true,
        time: DateTime.now().toString(),
        product: product,
      );
    });
    // if (_items.containsKey(product.id!)) {
    //   _items.update(product.id!, (value) {
    //     return CartModel(
    //       id: value.id,
    //       name: value.name,
    //       price: price,
    //       img: value.img,
    //       totquantity: value.totquantity! + totquantity,
    //       mquantity: value.mquantity! + maleQuantity,
    //       fquantity: value.fquantity! + feQuantity,
    //       pquantity: value.pquantity! + pairQuantity,
    //       isExisted: true,
    //       time: DateTime.now().toString(),
    //       product: product,
    //     );
    //   });
    // } else {
    //   _items.putIfAbsent(product.id!, () {
    //     print(
    //         ".............items =   $totquantity......................${product.id}..........");
    //     return CartModel(
    //       id: product.id,
    //       name: product.name,
    //       price: price,
    //       img: product.img,
    //       totquantity: totquantity,
    //       mquantity: maleQuantity,
    //       fquantity: feQuantity,
    //       pquantity: pairQuantity,
    //       isExisted: true,
    //       time: DateTime.now().toString(),
    //       product: product,
    //     );
    //   });
    // }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(dynamic product) {
    if (_items.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  void deletetCart(CartModel product) {
    _items.remove(product.id!);
    cartRepo.removeFromCartList(product);
    //  SharedPreferences.remove(product.id!);
    update();
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        int totalQuantity = value.totquantity ?? 0;
        if (key == product.id) {
          quantity = totalQuantity;
        }
      });
    }
    return quantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  double get totelAmount {
    double totel = 0;
    _items.forEach((key, value) {
      totel += value.price!;
    });
    return totel;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
    Get.to(() => OrderPlaced());
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  void knowcarts() {
    cartRepo.getCartList();
  }

  void clearCartHistory() {
    cartRepo.clearOrderHistory();
    update();
  }
}
