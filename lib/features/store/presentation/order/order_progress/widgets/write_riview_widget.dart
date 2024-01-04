import 'dart:io';

import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/review_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class WriteAreviewWidget extends StatefulWidget {
  const WriteAreviewWidget({
    super.key,
    required this.order,
    required this.product,
  });
  final dynamic order;
  final dynamic product;

  @override
  State<WriteAreviewWidget> createState() => _WriteAreviewWidgetState();
}

class _WriteAreviewWidgetState extends State<WriteAreviewWidget> {
  XFile? _image;
  // String timeWidget(String time) {
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
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
  Widget build(BuildContext context) {
    return SimpleButton(
        onPress: () {
          Get.find<UserInfoController>().getBreedersList();
          var breedersList = Get.find<UserInfoController>().breedersList;
          TextEditingController detailsController = TextEditingController();
          double ratingOn = 0.0;
          showDialog<void>(
            context: context,
            barrierDismissible:
                true, // Set to true if you want to dismiss the dialog by tapping outside
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return AlertDialog(
                    title: const Text('Review '),
                    content: ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        textWidget(
                            text: 'Swipe to rate',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).indicatorColor),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: RatingBar.builder(
                            glow: true,
                            glowColor: Theme.of(context).primaryColor,
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            //  allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                ratingOn = rating;
                              });
                              print(ratingOn);
                            },
                            itemSize: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _pickImage();
                            setState(() {});
                          },
                          child: Container(
                              width: 80,
                              height: 120,
                              decoration: BoxDecoration(
                                // border: Border.all(),
                                color: Theme.of(context).splashColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                  child: _image == null
                                      ? const Icon(
                                          Iconsax.image,
                                          size: 40,
                                        )
                                      : Image.file(File(_image!.path)))),
                        ),
                        smallSpace,
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).splashColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 60,
                          width: Get.width,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            style: TextStyle(
                                color: Theme.of(context).indicatorColor),
                            controller: detailsController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Theme.of(context).primaryColorLight),
                                hintText: 'Write review',
                                // prefixIcon: Icon(
                                //   Icons.home,
                                //   color: Colors.grey,
                                // ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          Get.find<ProductInfoController>().uploadFile(_image!);
                          ReviewModel details = ReviewModel(
                            productId: widget.order.productId,
                            rating: ratingOn,
                            img: 'images/${_image!.name}',
                            comment: detailsController.text,
                          );
                          Get.find<ReviewController>().addReview(details);
                          Navigator.of(context).pop();
                          showSuccessDialog(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        label: "Write a review");
  }
}
