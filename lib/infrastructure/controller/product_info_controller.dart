import 'dart:convert';
import 'dart:io';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/data/repository/product_info_repo.dart';
import 'package:betta_store/infrastructure/models/cart_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/infrastructure/models/respones_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

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
  String _thumbnailPath = "";
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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    update();
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: pickedFile.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 100,
        quality: 50,
      );

      if (pickedFile != null) {
        _thumbnailPath = thumbnailPath!;
        _video = File(pickedFile.path);
        print(_video);
        print("------------------");
      } else {
        print('No image selected.');
      }
      update();
    }
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

  // Future<void> uploadProductDetails({
  //   required String name,
  //   required String breeder,
  //   required String description,
  //   required int price,
  //   required int malePrice,
  //   required int femalePrice,
  //   required int stars,
  //   required String imgPath, // Replace with the path to the image file
  //   required String videoPath, // Replace with the path to the video file
  //   required int typeId,
  // }) async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse(AppConstents.BASE_URL + AppConstents.addProductUri));

  //   request.fields['name'] = name;
  //   request.fields['breeder'] = breeder;
  //   request.fields['description'] = description;
  //   request.fields['price'] = price.toString();
  //   request.fields['malePrice'] = malePrice.toString();
  //   request.fields['femalePrice'] = femalePrice.toString();
  //   request.fields['stars'] = stars.toString();
  //   request.fields['typeId'] = typeId.toString();

  //   // Add the image file
  //   if (imgPath != null && imgPath.isNotEmpty) {
  //     var imgFile = File(imgPath);
  //     var imgStream = http.ByteStream(imgFile.openRead());
  //     var imgLength = await imgFile.length();

  //     var imgUri =
  //         Uri.parse(AppConstents.BASE_URL + AppConstents.addProductUri);
  //     var imgRequest = http.MultipartRequest('POST', imgUri);
  //     var imgMultipartFile = http.MultipartFile(
  //       'img',
  //       imgStream,
  //       imgLength,
  //       filename: basename(imgFile.path),
  //       contentType:
  //           MediaType('image', 'jpeg'), // Adjust the content type as needed
  //     );
  //     imgRequest.files.add(imgMultipartFile);
  //     var imgResponse = await imgRequest.send();

  //     // You can handle the response for the image upload here if needed
  //   }

  //   // Add the video file
  //   if (videoPath != null && videoPath.isNotEmpty) {
  //     var videoFile = File(videoPath);
  //     var videoStream = http.ByteStream(videoFile.openRead());
  //     var videoLength = await videoFile.length();

  //     var videoUri =
  //         Uri.parse(AppConstents.BASE_URL + AppConstents.addProductUri);
  //     var videoRequest = http.MultipartRequest('POST', videoUri);
  //     var videoMultipartFile = http.MultipartFile(
  //       'video',
  //       videoStream,
  //       videoLength,
  //       filename: basename(videoFile.path),
  //       contentType:
  //           MediaType('video', 'mp4'), // Adjust the content type as needed
  //     );
  //     videoRequest.files.add(videoMultipartFile);
  //     var videoResponse = await videoRequest.send();

  //     // You can handle the response for the video upload here if needed
  //   }

  //   // Send the product details
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     // Handle the response from your Laravel backend
  //     print('Product uploaded successfully');
  //   } else {
  //     print('Failed to upload product' + videoPath.toString());
  //   }
  // }
}
