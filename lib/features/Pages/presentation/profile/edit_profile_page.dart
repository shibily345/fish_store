import 'dart:io';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/add/suucess_add_page.dart';
import 'package:betta_store/features/Pages/presentation/profile/widgets/edit_fields_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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

  @override
  void initState() {
    Get.find<UserInfoController>().getUserInfo();
    _nameController.text = Get.find<UserInfoController>().userModel.name!;
    _locationController.text =
        Get.find<UserInfoController>().userModel.location!;
    _emailController.text = Get.find<UserInfoController>().userModel.email!;
    super.initState();
  }

  _update() async {
    if (_image != null) {
      Get.find<ProductInfoController>().uploadFile(_image!);
    }

    Map<String, dynamic> detils = {
      'logo': _image != null
          ? 'images/${_image!.name}'
          : Get.find<UserInfoController>().userModel.logo!,
      'email': _emailController.text,
      'location': _locationController.text,
    };
    await Get.find<UserInfoController>().updateUserProfile(
        Get.find<UserInfoController>().userModel.id!, detils);
    Get.to(() => const ProductAdded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.0.h, left: 10.w),
            child: textWidget(
                text: "Edit Profile",
                color: Theme.of(context).indicatorColor,
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          bigSpace,
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        shape: BoxShape.circle),
                    // radius: 50,
                    width: 100,
                    height: 100,
                    child: Container(
                        child: _image == null
                            ? CachedNetworkImage(
                                height: 100.h,
                                width: 100.w,
                                imageUrl: AppConstents.BASE_URL +
                                    AppConstents.UPLOAD_URL +
                                    Get.find<UserInfoController>()
                                        .userModel
                                        .logo!,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[800]!,
                                  highlightColor: Colors.grey[700]!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        color: Colors.black),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.image),
                              )
                            : Image.file(File(_image!.path)))),
              ],
            ),
          ),
          bigSpace,
          EditProfileFielsWidgets(
            // nameController: _nameController,
            phoneController: _phoneController,
            locationController: _locationController,
            emailController: _emailController,
          ),
          smallSpace,
          SizedBox(
              width: 80,
              child: SimpleButton(
                  onPress: () {
                    _update();
                  },
                  label: "Submit"))
        ],
      ),
    );
  }
}
