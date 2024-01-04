import 'dart:io';

import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/privacy_terms.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';

import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/suucess_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateShop extends StatefulWidget {
  final int itemCount;
  const CreateShop({super.key, required this.itemCount});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  @override
  void initState() {
    super.initState();
    Get.find<UserInfoController>().getUserInfo();
  }

  XFile? _image;
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(
      text: Get.find<UserInfoController>().userModel.name!);
  final TextEditingController _upiId = TextEditingController();
  final TextEditingController _confirmUpiId = TextEditingController();
  final FocusNode _locationFocus = FocusNode();
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
              toolbarTitle: "Image Cropper",
              toolbarColor: const Color.fromARGB(238, 193, 190, 25),
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

  _update() async {
    if (_upiId.text != _confirmUpiId.text) {
      Get.snackbar(
          'Upi id not match', "Correct your upi id make sure it Payeble");
    } else if (_image == null) {
      Get.snackbar('Select Profile pic', "You didnot selected your logo");
    } else {
      Get.find<ProductInfoController>().uploadFile(_image!);
      Map<String, dynamic> detils = {
        'location': _locationController.text,
        'product_count': widget.itemCount.toString(),
        'logo': 'images/${_image!.name}',
        'sellproduct': 1.toString(),
        'payment_id': _upiId.text,
        'f_name': _nameController.text,
      };
      await Get.find<UserInfoController>()
          .updateUserProfile(
              Get.find<UserInfoController>().userModel.id!, detils)
          .then((value) {});
      Get.to(() => const ProductAdded());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        // height: 740,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            StartPage(pageController: _pageController),
            Container(
              margin: const EdgeInsets.all(20),
              height: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).splashColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bigSpace,
                    bigSpace,
                    textWidget(
                      text: "Add some Details ",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).indicatorColor,
                    ),
                    bigSpace,
                    InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: BlurContainer(
                          radius: 50,
                          width: 100,
                          height: 100,
                          child: Container(
                              child: _image == null
                                  ? const Icon(
                                      Iconsax.image,
                                      size: 40,
                                    )
                                  : Image.file(File(_image!.path)))),
                    ),
                    bigSpace,
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 40.h,
                        child: TextFormField(
                          //  focusNode: _nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Name',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 40.h,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: _locationController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Location',
                              prefixIcon: const Icon(
                                Icons.location_history,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    bigSpace,
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 40.h,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: _upiId,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Upi Id',
                              prefixIcon: const Icon(
                                Icons.currency_rupee,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 40.h,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: _confirmUpiId,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Confirm Upi Id',
                              prefixIcon: const Icon(
                                Icons.currency_rupee,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    bigSpace,
                    Align(
                        alignment: Alignment.centerRight,
                        child: SimpleButton(
                            onPress: () {
                              _update();
                            },
                            label: "Submit")),
                  ]
                      .animate(interval: 100.ms)
                      .fade()
                      .fadeIn(curve: Curves.easeInOutExpo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bigSpace,
          bigSpace,
          textWidget(
            text: "Are you a breeder?...",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).indicatorColor,
          ),
          textWidget(
            text: "Let's sell your 'High Quality Fishes and products here'",
            fontSize: 12,
            maxline: 2,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).indicatorColor,
          ),
          bigSpace,
          Container(
            height: 250,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/ui_elementsbgon/fishpack.webp'))),
          ),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleButton(
                    onPress: () {
                      Get.back();
                    },
                    label: "Later"),
                SimpleButton(
                    onPress: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    label: "Get Started"),
              ],
            ),
          ),
          bigSpace,
          const Center(child: PrivecyLabelWidget()),
        ].animate(interval: 100.ms).fade().fadeIn(curve: Curves.easeInOutExpo),
      ),
    );
  }
}
