import 'dart:io';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/suucess_add_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/my_shop.dart';
import 'package:betta_store/features/store/presentation/profile/widgets/edit_fields_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    Get.find<UserInfoController>().getUserInfo();
    _nameController.text = Get.find<UserInfoController>().userModel.name!;
    _phoneController.text = Get.find<UserInfoController>().userModel.phone!;
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
      'phone': _phoneController.text,
      'logo': _image != null
          ? 'images/' + _image!.name
          : Get.find<UserInfoController>().userModel.logo!,
      'email': _emailController.text,
      'location': _locationController.text,
    };
    await Get.find<UserInfoController>().updateUserProfile(
        Get.find<UserInfoController>().userModel.id!, detils);
    Get.to(() => ProductAdded());
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
                                placeholder: (context, url) => Center(
                                    child: CustomeLoader(
                                  bg: Colors.transparent,
                                )),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.image),
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
