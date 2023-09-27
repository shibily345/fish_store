import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/controller/user_Info_Controller.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (products) {
      List<dynamic> myProducts = products.productInfoList
          .where((products) =>
              products.breeder == Get.find<UserInfoController>().userModel.name)
          .toList();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: 18.0.h, left: 8.w, right: 7.w, top: 18.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRouts.getAddBettaPage(4));
                    },
                    child: BlurImageContainer(
                        image: "assets/ui_elementsbgon/2.png",
                        width: Get.width * 0.47,
                        height: 200.h,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              smallwidth,
                              const Icon(
                                Iconsax.add_circle,
                                color: Colors.white,
                                size: 26,
                              ),
                              textWidget(
                                  text: "Betta Fish",
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              smallwidth,
                            ],
                          ),
                        )),
                  ),
                  smallwidth,
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouts.getAddBettaPage(6));
                        },
                        child: BlurImageContainer(
                            image: "assets/ui_elementsbgon/koisfishes.jpeg",
                            width: Get.width * 0.4,
                            height: 100.h,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  smallwidth,
                                  const Icon(
                                    Iconsax.add_circle,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  textWidget(
                                      text: "Other Fishes",
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  smallwidth,
                                ],
                              ),
                            )),
                      ),
                      smallSpace,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouts.getAddBettaPage(5));
                        },
                        child: BlurImageContainer(
                            image: "assets/ui_elementsbgon/aquaplants.jpeg",
                            width: Get.width * 0.4,
                            height: 90.h,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  smallwidth,
                                  const Icon(
                                    Iconsax.add_circle,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  textWidget(
                                      text: "Aqua plants",
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  smallwidth,
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 18.0.h,
                left: 8.w,
                right: 7.w,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRouts.getAddBettaPage(7));
                    },
                    child: BlurImageContainer(
                        image: "assets/ui_elementsbgon/tank1.jpg",
                        width: Get.width * 0.47,
                        height: 60.h,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              smallwidth,
                              const Icon(
                                Iconsax.add_circle,
                                color: Colors.white,
                                size: 26,
                              ),
                              textWidget(
                                  text: "Aqua Items",
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              smallwidth,
                            ],
                          ),
                        )),
                  ),
                  smallwidth,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRouts.getAddBettaPage(8));
                    },
                    child: BlurImageContainer(
                        image: "assets/ui_elementsbgon/feedsof.jpg",
                        width: Get.width * 0.4,
                        height: 60.h,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              smallwidth,
                              const Icon(
                                Iconsax.add_circle,
                                color: Colors.white,
                                size: 26,
                              ),
                              textWidget(
                                  text: "Fish feeds",
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              smallwidth,
                            ],
                          ),
                        )),
                  ),
                  smallSpace,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 18.0.h, left: 8.w, right: 7.w, top: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                      text: "My Shop",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                  textWidget(
                      text: "${myProducts.length} Items",
                      color: Theme.of(context).primaryColorLight,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
              ),
              itemCount: myProducts
                  .length, // Replace with the number of items you have
              itemBuilder: (BuildContext context, int index) {
                // Replace this with your grid item widget
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      BlurContainer(
                          width: 200, height: 200, child: Container()),
                      Positioned(
                        //top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                                AppRouts.getfishDetails(myProducts[index].id));
                          },
                          child: Image.network(
                            AppConstents.BASE_URL +
                                AppConstents.UPLOAD_URL +
                                myProducts[index].img!,
                            width: 80.w,
                            height: 80.h,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.w,
                        bottom: 10.h,
                        child: InkWell(
                          child: textWidget(text: myProducts[index].name!),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
