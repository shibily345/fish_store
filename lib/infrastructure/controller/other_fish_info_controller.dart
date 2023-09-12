import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/data/repository/other_fish_info_repo%20copy%202.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/infrastructure/models/other_fish_detile_model.dart';
import 'package:get/get.dart';

class OtherFishInfoController extends GetxController {
  final OtherFishInfoRepo otherFishInfoRepo;

  OtherFishInfoController({required this.otherFishInfoRepo});
  List<dynamic> _otherFishInfoList = [];
  List<dynamic> get otherFishInfoList => _otherFishInfoList;
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
  bool _exist = false;
  bool get exist => _exist;
  double _totPrice = 0;
  double get totPrice => _totPrice;

  Future<void> getOtherFishInfoList() async {
    Response response = await otherFishInfoRepo.getOtherFishList();
    if (response.statusCode == 200) {
      print(
          "Got It ........................................................................................................");
      _otherFishInfoList = [];
      _otherFishInfoList
          .addAll(OtherFishinfo.fromJson(response.body).otherFishes);
      _isLoded = true;
      print(_otherFishInfoList);
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
    OtherFishModel otherFish,
  ) {
    _totelQuantity = 0;
    _quantity = 0;
    _maleQuantity = 0;
    _feQuantity = 0;
    _inCartItemCount = 0;
    _cart = cart;
    // exist = false;
    // _exist = _cart.existInCart(otherFish);
    // print(exist.toString() + ".............................");
    // if (exist) {
    //   _inCartItemCount = _cart.getQuantity(otherFish);
    // }
    print(_inCartItemCount.toString() + ".............................");
  }

  void addItem(OtherFishModel otherFish) {
    if (totelQuantity > 0) {
      // _cart.addItem(otherFish, _totelQuantity, _quantity, _maleQuantity,
      //     feQuantity, totPrice);
      _totelQuantity = 0;
      _cart.items.forEach((key, value) {
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
