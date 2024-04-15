import 'dart:convert';
import 'dart:io';
import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/controller/cart_controller.dart';
import 'package:betta_store/features/Pages/domain/models/cart_model.dart';
import 'package:betta_store/features/Pages/domain/models/products_model.dart';
import 'package:betta_store/features/Pages/domain/models/respones_model.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/add/suucess_add_page.dart';
import 'package:betta_store/features/products/data/repositories/product_info_repo.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getProductInfoList() async {
    Response response = await productInfoRepo.getProductList();
    if (response.statusCode == 200) {
      _productInfoList = ProductInfoModel.fromJson(response.body).products;
      _isLoded = true;
      update();
    } else {
      print("Fail: ${response.statusCode}");
    }
  }

  void setQuantity(bool isIncrement) {
    _quantity = checkQuantity(_quantity + (isIncrement ? 1 : -1));
    _updateTotalQuantity();
  }

  void setmaleQuantity(bool isIncrement) {
    _maleQuantity = checkQuantity(_maleQuantity + (isIncrement ? 1 : -1));
    _updateTotalQuantity();
  }

  void setfeQuantity(bool isIncrement) {
    _feQuantity = checkQuantity(_feQuantity + (isIncrement ? 1 : -1));
    _updateTotalQuantity();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      return 0;
    } else if (quantity > 10) {
      Get.snackbar('Stop', 'Its Max');
      return 10;
    } else {
      return quantity;
    }
  }

  void _updateTotalQuantity() {
    _totelQuantity = maleQuantity + feQuantity + quantity;
    update();
  }

  void getPrice(double price) {
    _totPrice = price;
  }

  void initNew(CartController cart, ProductModel product) {
    _resetQuantities();
    _cart = cart;
    _exist = _cart.existInCart(product);
    if (_exist) {
      _inCartItemCount = _cart.getQuantity(product);
    }
  }

  void _resetQuantities() {
    _totelQuantity = 0;
    _quantity = 0;
    _maleQuantity = 0;
    _feQuantity = 0;
    _inCartItemCount = 0;
  }

  void addItem(ProductModel product, double priceInTotal) {
    if (_totelQuantity > 0) {
      _cart.addItem(product, _totelQuantity, _quantity, _maleQuantity,
          _feQuantity, priceInTotal);
      _resetQuantities();
      _printCartItems();
    } else {
      Get.snackbar("Attention", 'No quantity selected');
    }
    update();
  }

  void _printCartItems() {
    _cart.items.forEach((key, value) {
      print(
          'Item: ${value.id}, Quantity: ${value.totquantity}, Male: $_maleQuantity');
    });
  }

  List<CartModel> get getItems => _cart.getItems;

  Future<ResponesModel> addProduct(ProductModel productModel) async {
    _isLoading = true;
    update();
    Response response = await productInfoRepo.addProduct(productModel);
    ResponesModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      String message = response.body["message"];
      responseModel = ResponesModel(true, message);
    } else {
      responseModel = ResponesModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('${AppConstents.BASE_URL}/api/v1/products/$productId'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Product deleted successfully');
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateProduct(
      int productId, ProductModel updatedProductData) async {
    final response = await http.patch(
      Uri.parse('${AppConstents.BASE_URL}/api/v1/products/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedProductData),
    );
    if (response.statusCode == 200) {
      print('Product updated successfully');
      Get.to(() => const ProductAdded());
    } else {
      print('Failed to update product. Status code: ${response.statusCode}');
    }
  }

  Future<String> uploadFile(XFile file) async =>
      _upload(file, AppConstents.uploadFile);
  Future<String> uploadVideo(XFile file) async =>
      _upload(file, AppConstents.uploadVideo);

  Future<String> _upload(XFile file, String endpoint) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConstents.BASE_URL}$endpoint'));
    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      return 'File uploaded successfully.';
    } else {
      return 'Error uploading file. Status code: ${response.statusCode}';
    }
  }
}
