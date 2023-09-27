import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:betta_store/infrastructure/controller/user_Info_Controller.dart';
import 'package:betta_store/presentation/helps/widgets/remove_bg.dart';
import 'package:betta_store/presentation/home/profile/my_shop/my_shop.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/custom.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
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
  final TextEditingController _malePriceController = TextEditingController();
  final TextEditingController _femalePController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  XFile? _image;
  XFile? _video;
  XFile? xFile;

  ProcessingStatus processingStatus = ProcessingStatus.notstarted;
  Uint8List? imgInBytes;

  ImgRemoveBg imgRemoveBg = ImgRemoveBg();
  String selectedOption = 'per pack';
  String _thumbnailPath = "";
  Future<Uint8List> fileToUint8List(File file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        () {
          //for loading
          setState(() {
            processingStatus = ProcessingStatus.processing;
          });

          imgRemoveBg.removeBg(context, _image!).then((value) {
            setState(() {
              processingStatus = ProcessingStatus.done;
              imgInBytes = value;
              _image = XFile(imgInBytes.toString());
              print("$_image........................................");
            });
          });
        };
      } else {
        print('No image selected.');
      }
    });
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
      String malePrice = _malePriceController.text.trim();
      String femalePrice = _femalePController.text.trim();
      if (widget.pageId == 4 || widget.pageId == 6) {
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
          // Get.find<ProductInfoController>().uploadProductDetails(
          //     name: name,
          //     breeder: "breeder",
          //     description: discription,
          //     price: pairPrice.toInt(),
          //     malePrice: malePrice.toInt(),
          //     femalePrice: femalePrice.toInt(),
          //     stars: 4,
          //     imgPath: _image!.path,
          //     videoPath: _video!.path,
          //     typeId: 4);
          // StreamedResponse response = await uploadImage(_image);

          ProductModel productDetails = ProductModel(
              name: name,
              breeder: Get.find<UserInfoController>().userModel.name,
              description: discription,
              price: pairPrice.toInt(),
              malePrice: malePrice.toInt(),
              femalePrice: femalePrice.toInt(),
              img: 'kk.png',
              video: "hh",
              stars: 4,
              typeId: widget.pageId);

          Get.find<ProductInfoController>()
              .addProduct(productDetails)
              .then((response) {
            if (response.isSuccess) {
              Get.snackbar("Added", "SuccessFully");
            } else {
              Get.snackbar(
                  "pattola bro Address", "seriikk adikk ${response.message}");
            }
          });

          // var request = http.MultipartRequest('POST',
          //     Uri.parse(AppConstents.BASE_URL + AppConstents.addProductUri));

          // if (_image != null && _image == null) {
          //   var imgFile = _image!;
          //   var imgStream = http.ByteStream(imgFile.openRead());
          //   var imgLength = await imgFile.length();

          //   var imgUri = Uri.parse('YOUR_LARAVEL_API_URL_FOR_IMAGE_UPLOAD');
          //   var imgRequest = http.MultipartRequest('POST', imgUri);
          //   var imgMultipartFile = http.MultipartFile(
          //     'img',
          //     imgStream,
          //     imgLength,
          //     filename: basename(imgFile.path),
          //     contentType:
          //         MediaType('image', 'jpeg'), // Adjust the content type as needed
          //   );
          //   imgRequest.files.add(imgMultipartFile);
          //   var imgResponse = await imgRequest.send();

          //   // You can handle the response for the image upload here if needed
          // }
          // if (_video != null) {
          //   var videoFile = _video!;
          //   var videoStream = http.ByteStream(videoFile.openRead());
          //   var videoLength = await videoFile.length();

          //   var videoUri = Uri.parse('YOUR_LARAVEL_API_URL_FOR_VIDEO_UPLOAD');
          //   var videoRequest = http.MultipartRequest('POST', videoUri);
          //   var videoMultipartFile = http.MultipartFile(
          //     'video',
          //     videoStream,
          //     videoLength,
          //     filename: basename(videoFile.path),
          //     contentType:
          //         MediaType('video', 'mp4'), // Adjust the content type as needed
          //   );
          //   videoRequest.files.add(videoMultipartFile);
          //   var videoResponse = await videoRequest.send();

          //   // You can handle the response for the video upload here if needed
          // }
        }
      } else {
        if (name.isEmpty) {
          showCustumeSnackBar("Enter product Name", title: "Name is Empty");
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
          // Get.find<ProductInfoController>().uploadProductDetails(
          //     name: name,
          //     breeder: "breeder",
          //     description: discription,
          //     price: pairPrice.toInt(),
          //     malePrice: malePrice.toInt(),
          //     femalePrice: femalePrice.toInt(),
          //     stars: 4,
          //     imgPath: _image!.path,
          //     videoPath: _video!.path,
          //     typeId: 4);
          // StreamedResponse response = await uploadImage(_image);

          ProductModel productDetails = ProductModel(
              name: name,
              breeder: Get.find<UserInfoController>().userModel.name,
              description: discription,
              price: pairPrice.toInt(),
              malePrice: malePrice.toInt(),
              femalePrice: femalePrice.toInt(),
              img: 'kk.png',
              video: "hh",
              stars: 4,
              typeId: widget.pageId);

          Get.find<ProductInfoController>()
              .addProduct(productDetails)
              .then((response) {
            if (response.isSuccess) {
              Get.snackbar("Added", "SuccessFully");
            } else {
              Get.snackbar(
                  "pattola bro Address", "seriikk adikk ${response.message}");
            }
          });

          // var request = http.MultipartRequest('POST',
          //     Uri.parse(AppConstents.BASE_URL + AppConstents.addProductUri));

          // if (_image != null && _image == null) {
          //   var imgFile = _image!;
          //   var imgStream = http.ByteStream(imgFile.openRead());
          //   var imgLength = await imgFile.length();

          //   var imgUri = Uri.parse('YOUR_LARAVEL_API_URL_FOR_IMAGE_UPLOAD');
          //   var imgRequest = http.MultipartRequest('POST', imgUri);
          //   var imgMultipartFile = http.MultipartFile(
          //     'img',
          //     imgStream,
          //     imgLength,
          //     filename: basename(imgFile.path),
          //     contentType:
          //         MediaType('image', 'jpeg'), // Adjust the content type as needed
          //   );
          //   imgRequest.files.add(imgMultipartFile);
          //   var imgResponse = await imgRequest.send();

          //   // You can handle the response for the image upload here if needed
          // }
          // if (_video != null) {
          //   var videoFile = _video!;
          //   var videoStream = http.ByteStream(videoFile.openRead());
          //   var videoLength = await videoFile.length();

          //   var videoUri = Uri.parse('YOUR_LARAVEL_API_URL_FOR_VIDEO_UPLOAD');
          //   var videoRequest = http.MultipartRequest('POST', videoUri);
          //   var videoMultipartFile = http.MultipartFile(
          //     'video',
          //     videoStream,
          //     videoLength,
          //     filename: basename(videoFile.path),
          //     contentType:
          //         MediaType('video', 'mp4'), // Adjust the content type as needed
          //   );
          //   videoRequest.files.add(videoMultipartFile);
          //   var videoResponse = await videoRequest.send();

          //   // You can handle the response for the video upload here if needed
          // }
        }
      }
    }

    //   Future<StreamedResponse> uploadImage(PickedFile? data) async {}

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
                  text: "Sell my bettaFish",
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
                    if (widget.pageId == 4 || widget.pageId == 6)
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
                    else
                      Container(),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: BlurContainer(
                width: Get.width,
                height: 50.h,
                child: TextFormField(
                  focusNode: nameFocus,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(discriptionFocus);
                  },
                  style: TextStyle(color: Theme.of(context).indicatorColor),
                  controller: _nameController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                      hintText: 'Full Name',
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: BlurContainer(
                width: Get.width,
                height: 100.h,
                child: TextFormField(
                  focusNode: discriptionFocus,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(pairPriceFocus);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  style: TextStyle(color: Theme.of(context).indicatorColor),
                  controller: _discriptionController,
                  decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                      hintText: 'Full discription',
                      // prefixIcon: Icon(
                      //   Icons.home,
                      //   color: Colors.grey,
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallwidth,
                  if (widget.pageId == 4 || widget.pageId == 6)
                    textWidget(
                        text: "Price /pair",
                        color: Theme.of(context).indicatorColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)
                  else
                    DropdownButton<String>(
                      // Step 2: Create a DropdownButton with options and a value.
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        // Step 3: Update the selectedOption variable.
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                      items: <String>[
                        'per pack',
                        'per item',
                        'per gram',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  BlurContainer(
                    width: 150.w,
                    height: 50.h,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: pairPriceFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(malePriceFocus);
                      },
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _pairPriceController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Pair',
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            color: Theme.of(context).indicatorColor,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallwidth,
                  textWidget(
                      text: "Price /Male",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  BlurContainer(
                    width: 150.w,
                    height: 50.h,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: malePriceFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(femalePriceFocus);
                      },
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _malePriceController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: ' Male',
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallwidth,
                  textWidget(
                      text: "Price /Female",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  BlurContainer(
                    width: 150.w,
                    height: 50.h,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: femalePriceFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {},
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _femalePController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Female',
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallwidth,
                  textWidget(
                      text: "Age of Fish",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  BlurContainer(
                    width: 190.w,
                    height: 50.h,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: ageFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {},
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _ageController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Age in months',
                          prefixIcon: const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
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
          ],
        ),
      ),
    ));
  }
}
