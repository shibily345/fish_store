import 'dart:io';
import 'dart:typed_data';

import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';

import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/my_shop/details/widgets/edit_fields_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class EditMainProductPage extends StatefulWidget {
  const EditMainProductPage({super.key, required this.pageId});
  final int pageId;
  @override
  State<EditMainProductPage> createState() => _EditMainProductPageState();
}

enum ProcessingStatus {
  notstarted,
  processing,
  done;
}

class _EditMainProductPageState extends State<EditMainProductPage> {
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

  String selectedOption = 'pack';
  String _thumbnailPath = "";
  List<dynamic> allProducts = [];
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

  Future<void> _addall() async {
    setState(() {});
  }

  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    _addall();
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
    var product = allProducts.firstWhere((p) => p.id == widget.pageId);
    _nameController.text = product.name!;
    _discriptionController.text = product.description!;
    _pairPriceController.text = product.price!.toString();
    _malePriceController.text = product.malePrice!.toString();
    _femalePController.text = product.femalePrice!.toString();
    if (_image == null) {
      image = product.img!;
    } else {
      image = 'images/${_image!.name}';
    }
    if (_video == null) {
      video = product.video!;
    } else if (product.typeId != 4 || product.typeId != 6) {
      video = product.video ?? selectedOption;
    } else {
      video = 'files/${_video!.name}';
    }
    super.initState();
  }

  final FocusNode nameFocus = FocusNode();
  final FocusNode discriptionFocus = FocusNode();
  final FocusNode pairPriceFocus = FocusNode();
  final FocusNode malePriceFocus = FocusNode();
  final FocusNode femalePriceFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  _adddiscription() async {
    var product = allProducts.firstWhere((p) => p.id == widget.pageId);
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
      showCustumeSnackBar("Enter product Price", title: "pairPrice is Empty");
    } else {
      if (_image != null) {
        Get.find<ProductInfoController>().uploadFile(_image!);
      }
      if (_video != null) {
        Get.find<ProductInfoController>().uploadVideo(_video!);
      }
      ProductModel productDetails = ProductModel(
          name: name,
          breeder: Get.find<UserInfoController>().userModel.name,
          sellerId: Get.find<UserInfoController>().userModel.id,
          description: discription,
          price: int.parse(pairPrice),
          malePrice: product.typeId != 4 || product.typeId != 6
              ? 0
              : int.parse(malePrice),
          femalePrice: int.parse(femalePrice),
          img: image,
          video: product.typeId != 4 || product.typeId != 6
              ? selectedOption
              : video,
          stars: "5",
          typeId: product.typeId!);
      print(image! + video!);
      Get.find<ProductInfoController>().updateProduct(
        widget.pageId,
        productDetails,
      );
    }
  }

  String? image;
  String? video;
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

  @override
  Widget build(BuildContext context) {
    var product = allProducts.firstWhere((p) => p.id == widget.pageId);
    //   Future<StreamedResponse> uploadImage(PickedFile? data) async {}

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
                  text: "Edit your Product",
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
                    if (product.typeId == 4 || product.typeId == 6)
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
                      Container()
                  ],
                )),
            EditFielsWidgets(
              nameController: _nameController,
              discriptionController: _discriptionController,
              pairPriceController: _pairPriceController,
              malePriceController: _malePriceController,
              femalePController: _femalePController,
              product: product,
              priceForWidget: product.typeId == 4 || product.typeId == 6
                  ? textWidget(
                      text: "Price /pair",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)
                  : DropdownButton<String>(
                      // Step 2: Create a DropdownButton with options and a value.
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        // Step 3: Update the selectedOption variable.
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
                      text: 'Submit',
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
