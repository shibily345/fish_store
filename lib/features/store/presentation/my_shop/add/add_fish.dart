import 'dart:io';
import 'dart:typed_data';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/suucess_add_page.dart';

import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/widgets/add_fields_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddBettaPage extends StatefulWidget {
  const AddBettaPage({super.key, required this.pageId});
  final int pageId;
  @override
  State<AddBettaPage> createState() => _AddBettaPageState();
}

enum ProcessingStatus {
  notstarted,
  processing,
  done;
}

class _AddBettaPageState extends State<AddBettaPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _pairPriceController = TextEditingController();
  final TextEditingController _malePriceController =
      TextEditingController(text: '0');
  final TextEditingController _femalePController =
      TextEditingController(text: '0');

  XFile? _image;
  XFile? _video;

  ProcessingStatus processingStatus = ProcessingStatus.notstarted;
  Uint8List? imgInBytes;

  String selectedOption = 'pack';
  String _thumbnailPath = "";
  Future<Uint8List> fileToUint8List(File file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Crop Image ",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        _image = XFile(croppedFile.path);
      });
      // reload();
    }
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

      setState(() {
        if (pickedFile != null) {
          _thumbnailPath = thumbnailPath!;
          _video = pickedFile;
          print(_video);
          print("------------------");
        } else {
          print('No image selected.');
        }
      });
    }
  }

  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];

  @override
  void initState() {
    Get.find<AuthController>().updateToken();
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _adddiscription() async {
      String name = _nameController.text.trim();
      String discription = _discriptionController.text.trim();
      String pairPrice = _pairPriceController.text.trim();
      String malePrice = _malePriceController.text.trim();
      String femalePrice = _femalePController.text.trim();

      if (name.isEmpty) {
        showCustumeSnackBar("Enter Your Name", title: "Name is Empty");
      } else if (discription.isEmpty) {
        showCustumeSnackBar("Enter Your discription",
            title: "discription is Empty");
      } else if (pairPrice.isEmpty) {
        showCustumeSnackBar("Enter Your pairPrice",
            title: "pairPrice is Empty");
      } else if (_image == null) {
        showCustumeSnackBar("Select an image",
            title: "Select suiteble image for your product");
      } else if (_video == null) {
        showCustumeSnackBar("Select a video",
            title: "Select suiteble video for your product");
      } else {
        Get.find<ProductInfoController>().uploadFile(_image!);
        Get.find<ProductInfoController>().uploadVideo(_video!);
        ProductModel productDetails = ProductModel(
            name: name,
            breeder: Get.find<UserInfoController>().userModel.name,
            sellerId: Get.find<UserInfoController>().userModel.id,
            description: discription,
            price: int.parse(pairPrice),
            malePrice: int.parse(malePrice),
            femalePrice: int.parse(femalePrice),
            img: 'images/${_image!.name}',
            video: 'files/${_video!.name}',
            stars: "5",
            typeId: widget.pageId);
        Map<String, dynamic> detils = {
          'product_count':
              '${allProducts.where((products) => products.breeder == Get.find<UserInfoController>().userModel.name).toList().length + 1}',
        };

        String token = Get.find<UserInfoController>().userModel.fcmToken!;
        NotificationHelper.sendPushNotification(
            token,
            "Your product published successfully  wait for customer response",
            "Added succeffully");
        Get.find<UserInfoController>()
            .updateUserProfile(
                Get.find<UserInfoController>().userModel.id!, detils)
            .then((value) {
          print("count updated.................................");
        });
        Get.find<ProductInfoController>()
            .addProduct(productDetails)
            .then((response) {
          if (response.isSuccess) {
            Get.snackbar("Added", "SuccessFully");
            Get.to(() => const ProductAdded());
          } else {
            Get.snackbar("Error Occurred", "Report us ASAP Profil>Contact us");
          }
        });
      }
    }

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                bigSpace,
                Padding(
                  padding: EdgeInsets.only(top: 18.0.h, left: 10.w),
                  child: textWidget(
                      text: "Enter product details",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        right: 10.w, bottom: 20, left: 10.w, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: BlurImageContainer(
                              width: 150,
                              height: 120,
                              image: '',
                              child: Container(
                                  child: _image == null
                                      ? const Icon(
                                          Iconsax.image,
                                          size: 40,
                                        )
                                      : Image.file(File(_image!.path)))),
                        ),
                        InkWell(
                          onTap: () {
                            _pickVideo();
                          },
                          child: BlurImageContainer(
                              width: 150,
                              height: 120,
                              image: '',
                              child: Container(
                                  child: _video == null
                                      ? const Icon(
                                          Iconsax.video,
                                          size: 40,
                                        )
                                      : Image.file(File(_thumbnailPath)))),
                        )
                      ],
                    )),
                AddFielsWidgets(
                    nameController: _nameController,
                    discriptionController: _discriptionController,
                    pairPriceController: _pairPriceController,
                    malePriceController: _malePriceController,
                    femalePController: _femalePController),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 0.0.w),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(160, 20, 10, 0),
                    width: 200.w,
                    height: 50.h,
                    child: SimpleButton(
                      onPress: () {
                        _adddiscription();
                        loadResources();
                      },
                      label: 'Add new product',
                    ),
                  ),
                )),
                bigSpace,
                bigSpace,
                bigSpace
              ]
                  .animate(interval: 100.ms)
                  .fade()
                  .fadeIn(curve: Curves.easeInOut),
            ),
          ),
        ));
  }
}
