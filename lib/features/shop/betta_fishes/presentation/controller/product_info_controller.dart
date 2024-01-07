import 'dart:convert';
import 'dart:io';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/shop/betta_fishes/data/repositories/product_info_repo.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/store/domain/models/cart_model.dart';
import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:betta_store/features/store/domain/models/respones_model.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/suucess_add_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  bool _exist = false;
  bool get exist => _exist;
  double _totPrice = 0;
  double get totPrice => _totPrice;
  File? _image;
  File? get image => _image;
  File? _video;
  File? get video => _video;
  final String _thumbnailPath = "";
  String get thumbnailPath => _thumbnailPath;
  Future<void> getProductInfoList() async {
    Response response = await productInfoRepo.getProductList();
    if (response.statusCode == 200) {
      print(
          "Got It ........................................................................................................");
      _productInfoList = [];
      _productInfoList
          .addAll(ProductInfoModel.fromJson(response.body).products);
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
    // exist = false;
    _exist = _cart.existInCart(product);
    print("$exist.............................");
    if (exist) {
      _inCartItemCount = _cart.getQuantity(product);
    }
    print("$_inCartItemCount.............................");
  }

  void addItem(ProductModel product, double priceInTotel) {
    if (totelQuantity > 0) {
      _cart.addItem(product, _totelQuantity, _quantity, _maleQuantity,
          feQuantity, priceInTotel);
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponesModel> addProduct(ProductModel productModel) async {
    _isLoading = true;
    update();
    Response response = await productInfoRepo.addProduct(productModel);
    ResponesModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      String message = response.body["message"];
      responseModel = ResponesModel(true, message);
    } else {
      print("Nadakkola bosse...............");
      responseModel = ResponesModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('${AppConstents.BASE_URL}/api/v1/products/products/$productId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // Add any additional headers as needed
      },
    );

    if (response.statusCode == 200) {
      // Product deleted successfully
      print('Product deleted successfully');
    } else {
      // Failed to delete the product
      print('Failed to delete product. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateProduct(
      int productId, ProductModel updatedProductData) async {
    final response = await http.patch(
      Uri.parse('${AppConstents.BASE_URL}/api/v1/products/products/$productId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // Add any additional headers as needed
      },
      body: jsonEncode(updatedProductData),
    );

    if (response.statusCode == 200) {
      // Product updated successfully
      print('Product updated successfully');
      Get.to(() => const ProductAdded());
    } else {
      // Failed to update the product
      print('Failed to update product. Status code: ${response.statusCode}');
    }
  }

  Future<String> uploadFile(XFile file) async {
    // Create a new MultipartRequest object.
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstents.BASE_URL + AppConstents.uploadFile));

    // Add the file to the request.
    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    // Send the request.
    var response = await request.send();

    // Check the response status code.
    if (response.statusCode == 200) {
      print(
          ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");
      // The file was uploaded successfully.
      return 'File uploaded successfully.';
    } else {
      print(
          "???????????????????????????????????????????????${response.statusCode}??????????????????????????");
      // An error occurred while uploading the file.
      return 'Error uploading file.';
    }
  }

  Future<String> uploadVideo(XFile file) async {
    // Create a new MultipartRequest object.
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstents.BASE_URL + AppConstents.uploadVideo));

    // Add the file to the request.
    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    // Send the request.
    var response = await request.send();

    // Check the response status code.
    if (response.statusCode == 200) {
      print(">8888888888888888888888888888888888888888888888>>>>>>>>>>>>>.");
      // The file was uploaded successfully.
      return 'File uploaded successfully.';
    } else {
      print("?????888888888888888888888888?????????????");
      // An error occurred while uploading the file.
      return 'Error uploading file.';
    }
  }
}
