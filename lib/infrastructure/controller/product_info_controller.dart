import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/data/repository/product_info_repo.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:get/get.dart';

class ProductInfoController extends GetxController {
  final ProductInfoRepo productInfoRepo;

  ProductInfoController({required this.productInfoRepo});
  List<dynamic> _productInfoList = [];
  List<dynamic> get productInfoList => _productInfoList;
  late CartController _cart;
  bool _isLoded = false;
  bool get isLoaded => _isLoded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _maleQuantity = 0;
  int get maleQuantity => _maleQuantity;
  int _feQuantity = 0;
  int get feQuantity => _feQuantity;
  int _inCartItemCount = 0;
  int get inCartItemCount => _inCartItemCount;
  int _totelQuantity = 0;
  int get totelQuantity => _totelQuantity;
  double _totPrice = 0;
  double get totPrice => _totPrice;

  Future<void> getProductInfoList() async {
    Response response = await productInfoRepo.getProductList();
    if (response.statusCode == 200) {
      print(
          "Got It ........................................................................................................");
      _productInfoList = [];
      _productInfoList.addAll(Fishinfo.fromJson(response.body).products);
      _isLoded = true;
      print(_productInfoList);
      update();
    } else {
      print("Fail..........${response.statusText}......................");
    }
  }

  void setQuantity(bool isIcrement) {
    if (isIcrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    _totelQuantity = maleQuantity + feQuantity + (quantity);
    update();
  }

  void getPrice(double price) {
    _totPrice = price;
  }

  void setmaleQuantity(bool isIcrement) {
    if (isIcrement) {
      _maleQuantity = checkQuantity(_maleQuantity + 1);
    } else {
      _maleQuantity = checkQuantity(_maleQuantity - 1);
    }
    _totelQuantity = maleQuantity + feQuantity + (quantity);
    update();
  }

  void setfeQuantity(bool isIcrement) {
    if (isIcrement) {
      _feQuantity = checkQuantity(_feQuantity + 1);
    } else {
      _feQuantity = checkQuantity(_feQuantity - 1);
    }
    _totelQuantity = maleQuantity + feQuantity + (quantity);
    update();
  }

  int checkQuantity(int quantity) {
    print(totelQuantity);
    if (quantity < 0) {
      return 0;
    } else if (quantity > 10) {
      Get.snackbar('Stop', 'Its Max');
      return 10;
    } else {
      return quantity;
    }
  }

  void initNew(
    CartController cart,
    ProductModel product,
  ) {
    _totelQuantity = 0;
    _quantity = 0;
    _maleQuantity = 0;
    _feQuantity = 0;
    _inCartItemCount = 0;
    _cart = cart;
    var exist = false;

    exist = _cart.existInCart(product);
    print(exist.toString() + ".............................");
    if (exist) {
      _inCartItemCount = _cart.getQuantity(product);
    }
    print(_inCartItemCount.toString() + ".............................");
  }

  void addItem(ProductModel product) {
    if (totelQuantity > 0) {
      _cart.addItem(product, _totelQuantity, _quantity, _maleQuantity,
          feQuantity, totPrice);
      _totelQuantity = 0;
      _cart.item.forEach((key, value) {
        print('the id is.....................' +
            value.id.toString() +
            "             the quntity is          " +
            value.totquantity.toString() +
            "             ....." +
            _maleQuantity.toString());
      });
    } else {
      Get.snackbar("Hey Don't", 'You did not select any thing');
    }
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
