import 'dart:io';

import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/core/utils/widgets/text_fields.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';

import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/suucess_add_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/my_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class CreateShop extends StatefulWidget {
  final int itemCount;
  const CreateShop({super.key, required this.itemCount});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  XFile? _image;
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocus = FocusNode();
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

  _update() async {
    Get.find<ProductInfoController>().uploadFile(_image!);
    Map<String, dynamic> detils = {
      'location': _locationController.text,
      'product_count': widget.itemCount.toString(),
      'logo': 'images/' + _image!.name,
      'sellproduct': 1.toString(),
    };
    await Get.find<UserInfoController>()
        .updateUserProfile(Get.find<UserInfoController>().userModel.id!, detils)
        .then((value) {});
    Get.to(() => ProductAdded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: 540,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            StartPage(pageController: _pageController),
            Container(
              margin: EdgeInsets.all(20),
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).splashColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                        focusNode: _locationFocus,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_locationFocus);
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        style:
                            TextStyle(color: Theme.of(context).indicatorColor),
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
                  bigSpace,
                  Align(
                      alignment: Alignment.centerRight,
                      child: SimpleButton(
                          onPress: () {
                            _update();
                          },
                          label: "Submit")),
                ],
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
      margin: EdgeInsets.all(20),
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).splashColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
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
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/ui_elementsbgon/fishpack.webp'))),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleButton(onPress: () {}, label: "Later"),
                SimpleButton(
                    onPress: () {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    label: "Get Started"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
