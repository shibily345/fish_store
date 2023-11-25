import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/shop/items/data/repositories/items_info_repo.dart';
import 'package:betta_store/features/shop/items/data/repositories/items_info_repo.dart';
import 'package:betta_store/features/store/domain/models/cart_model.dart';
import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:get/get.dart';

class ItemsInfoController extends GetxController {
  final ItemsInfoRepo itemsInfoRepo;

  ItemsInfoController({required this.itemsInfoRepo});
  List<dynamic> _itemsInfoList = [];
  List<dynamic> get itemsInfoList => _itemsInfoList;
  late CartController _cart;
  bool _isLoded = false;
  bool get isLoaded => _isLoded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItemCount = 0;
  int get inCartItemCount => _inCartItemCount;
  int _totelQuantity = 0;
  int get totelQuantity => _totelQuantity;
  bool _exist = false;
  bool get exist => _exist;
  double _totPrice = 0;
  double get totPrice => _totPrice;

  Future<void> getItemsInfoList() async {
    Response response = await itemsInfoRepo.getItemsList();
    if (response.statusCode == 200) {
      print(
          "Got It .items hoooi.......................................................................................................");
      _itemsInfoList = [];
      _itemsInfoList.addAll(ProductInfoModel.fromJson(response.body).products);
      _isLoded = true;
      print(_itemsInfoList);
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
    _totelQuantity = _quantity;
    update();
  }

  void getPrice(double price) {
    _totPrice = price;
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
    ProductModel items,
  ) {
    _totelQuantity = 0;
    _quantity = 0;

    _inCartItemCount = 0;
    _cart = cart;

    _exist = _cart.existInCart(items);
    print(exist.toString() + ".............................");
    if (exist) {
      _inCartItemCount = _cart.getQuantity(items);
    }
    print(_inCartItemCount.toString() + ".............................");
  }

  void addItem(ProductModel items) {
    if (totelQuantity > 0) {
      _cart.addItem(items, _totelQuantity, _quantity, 0, 0, totPrice);
      _totelQuantity = 0;
      _cart.items.forEach((key, value) {});
    } else {
      Get.snackbar("Hey Don't", 'You did not select any thing');
    }
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
