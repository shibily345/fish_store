import 'dart:io';
import 'dart:typed_data';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/helper/notification.dart';
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

import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/widgets/add_other_fields_widget%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddOtherPage extends StatefulWidget {
  const AddOtherPage({super.key, required this.pageId});
  final int pageId;
  @override
  State<AddOtherPage> createState() => _AddOtherPageState();
}

enum ProcessingStatus {
  notstarted,
  processing,
  done;
}

class _AddOtherPageState extends State<AddOtherPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _pairPriceController = TextEditingController();

  String selectedOption = 'pack';
  XFile? _image;

  ProcessingStatus processingStatus = ProcessingStatus.notstarted;
  Uint8List? imgInBytes;
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
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
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
              toolbarColor: Theme.of(context).primaryColor,
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

  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];

  @override
  void initState() {
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
    Get.find<AuthController>().updateToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode nameFocus = FocusNode();
    final FocusNode discriptionFocus = FocusNode();
    final FocusNode pairPriceFocus = FocusNode();
    final FocusNode malePriceFocus = FocusNode();
    final FocusNode femalePriceFocus = FocusNode();
    final FocusNode ageFocus = FocusNode();
    _adddiscription() async {
      String name = _nameController.text.trim();
      String discription = _discriptionController.text.trim();
      String pairPrice = _pairPriceController.text.trim();

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
      } else {
        ProductModel productDetails = ProductModel(
            name: name,
            breeder: Get.find<UserInfoController>().userModel.name,
            sellerId: Get.find<UserInfoController>().userModel.id,
            description: discription,
            price: int.parse(pairPrice),
            malePrice: 0,
            femalePrice: 0,
            img: 'images/${_image!.name}',
            video: selectedOption,
            stars: "5",
            typeId: widget.pageId);
        String token = Get.find<UserInfoController>().userModel.fcmToken!;
        NotificationHelper.sendPushNotification(
            token,
            "Your product published successfully  wait for customer response",
            "Added succeffully");
        print(
            "${_image!.name}............................................============================");
        Get.find<ProductInfoController>()
            .addProduct(productDetails)
            .then((response) {
          if (response.isSuccess) {
            Get.find<ProductInfoController>().uploadFile(_image!);
            Get.snackbar("Added", "SuccessFully");
            Get.to(() => const ProductAdded());
          } else {
            Get.snackbar(
                "Error Occurred", "Report us immidietly Profil>Contact us");
          }
        });
        print(
          '${allProducts.where((products) => products.breeder == Get.find<UserInfoController>().userModel.name).toList().length + 1}'
          '......................]]]]]]]]]]]]]]]]]]]]]]',
        );
        Map<String, dynamic> detils = {
          'product_count':
              '${allProducts.where((products) => products.breeder == Get.find<UserInfoController>().userModel.name).toList().length + 1}',
        };
        Get.find<UserInfoController>()
            .updateUserProfile(
                Get.find<UserInfoController>().userModel.id!, detils)
            .then((value) {
          print("count updated");
        });
      }
    }

    @override
    void dispose() {
      // Dispose of the FocusNodes when they are no longer needed
      nameFocus.dispose();
      discriptionFocus.dispose();
      pairPriceFocus.dispose();
      malePriceFocus.dispose();
      femalePriceFocus.dispose();
      ageFocus.dispose();
      super.dispose();
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            bigSpace,
            bigSpace,
            bigSpace,
            Padding(
              padding: EdgeInsets.only(top: 18.0.h, left: 10.w),
              child: textWidget(
                  text: "Sell my Product",
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
                  ],
                )),
            AddOtherFielsWidgets(
              nameController: _nameController,
              discriptionController: _discriptionController,
              pairPriceController: _pairPriceController,
              dropdown: DropdownButton<String>(
                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue!;
                  });
                },
                items: <String>[
                  'pack',
                  'item',
                  'gram',
                  'bunch',
                  'kg',
                  'stem',
                  '100gram',
                  '50gram',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(top: 0.0.w),
              child: Container(
                margin: const EdgeInsets.fromLTRB(160, 20, 10, 0),
                width: 200.w,
                height: 50.h,
                child: MaterialButton(
                  onPressed: () {
                    _adddiscription();
                    loadResources();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Theme.of(context).primaryColor,
                  child: textWidget(
                      text: 'Add new product',
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16),
                ),
              ),
            )),
            bigSpace,
            bigSpace,
            bigSpace
          ].animate(interval: 100.ms).fade().fadeIn(curve: Curves.easeInOut),
        ),
      ),
    ));
  }
}
