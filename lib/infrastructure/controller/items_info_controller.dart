import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/data/repository/items_info_repo.dart';
import 'package:betta_store/infrastructure/data/repository/items_info_repo.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/infrastructure/models/items_detile_model.dart';
import 'package:betta_store/infrastructure/models/plant_detile_model.dart';
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
      _itemsInfoList.addAll(ItemsInfo.fromJson(response.body).aquaItems);
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
    ItemsModel items,
  ) {
    _totelQuantity = 0;
    _quantity = 0;

    _inCartItemCount = 0;
    _cart = cart;
    // exist = false;
    // _exist = _cart.existInCart(items);
    // print(exist.toString() + ".............................");
    // if (exist) {
    //   _inCartItemCount = _cart.getQuantity(items);
    // }
    print(_inCartItemCount.toString() + ".............................");
  }

  void addItem(PlantModel items) {
    if (totelQuantity > 0) {
      // _cart.addItem(items, _totelQuantity, _quantity, _maleQuantity,
      //     feQuantity, totPrice);
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