import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get item => _items;
  int _incartItems = 0;
  int get inCartItems => _incartItems;
  void addItem(
    ProductModel product,
    int totquantity,
    int pairQuantity,
    int maleQuantity,
    int feQuantity,
    double price,
  ) {
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        return CartModel(
          id: value.id,
          name: value.name,
          price: price,
          img: value.img,
          totquantity: value.totquantity! + totquantity,
          mquantity: value.mquantity! + maleQuantity,
          fquantity: value.fquantity! + feQuantity,
          pquantity: value.pquantity! + pairQuantity,
          isExisted: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
    } else {
      _items.putIfAbsent(product.id!, () {
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
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  void deletetCart(CartModel product) {
    _items.remove(product.id!);
    update();
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.totquantity!;
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
}