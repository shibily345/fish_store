import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';

import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/my_shop/create_shop_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/shop_orders_page.dart';
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
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (products) {
      List<dynamic> myProducts = allProducts
          .where((products) =>
              products.breeder == Get.find<UserInfoController>().userModel.name)
          .toList();
      return Get.find<UserInfoController>().userModel.sellproduct == 1
          ? Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: products.isLoaded
                  ? RefreshIndicator(
                      onRefresh: _addall,
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              Get.to(() => ShopOrders());
                            },
                            title: Stack(
                              children: [
                                Container(
                                  child: Center(
                                    child: textWidget(
                                        text: "New Orders ",
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  width: Get.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context).splashColor),
                                ),
                                Positioned(
                                    bottom: 10,
                                    right: 20,
                                    child: textWidget(
                                        text: Get.find<OrderController>()
                                                .sellerOrderList
                                                .length
                                                .toString() +
                                            "  New Orders",
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.4),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 18.0.h,
                                left: 8.w,
                                right: 7.w,
                                top: 18.h),
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
                                        Get.toNamed(
                                            AppRouts.getAddBettaPage(6));
                                      },
                                      child: BlurImageContainer(
                                          image:
                                              "assets/ui_elementsbgon/koisfishes.jpeg",
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                                smallwidth,
                                              ],
                                            ),
                                          )),
                                    ),
                                    smallSpace,
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRouts.getAddOthersPage(5));
                                      },
                                      child: BlurImageContainer(
                                          image:
                                              "assets/ui_elementsbgon/aquaplants.jpeg",
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                    Get.toNamed(AppRouts.getAddOthersPage(7));
                                  },
                                  child: BlurImageContainer(
                                      image: "assets/ui_elementsbgon/tank1.jpg",
                                      width: Get.width * 0.47,
                                      height: 60.h,
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
                                    Get.toNamed(AppRouts.getAddOthersPage(8));
                                  },
                                  child: BlurImageContainer(
                                      image:
                                          "assets/ui_elementsbgon/feedsof.jpg",
                                      width: Get.width * 0.4,
                                      height: 60.h,
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
                                bottom: 18.0.h,
                                left: 8.w,
                                right: 7.w,
                                top: 18.h),
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
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of columns
                            ),
                            itemCount: myProducts
                                .length, // Replace with the number of items you have
                            itemBuilder: (BuildContext context, int index) {
                              // Replace this with your grid item widget
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).splashColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 200,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRouts.getMyproductEditPage(
                                                    myProducts[index].id));
                                          },
                                          child: Container(
                                            height: 70.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      AppConstents.BASE_URL +
                                                          AppConstents
                                                              .UPLOAD_URL +
                                                          myProducts[index]
                                                              .img!,
                                                    ))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        textWidget(
                                            text: myProducts[index].name!,
                                            color: Theme.of(context)
                                                .indicatorColor,
                                            fontSize: 10),
                                      ],
                                    )),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : const CustomeLoader())
          : CreateShop(
              itemCount: myProducts.length,
            );
    });
  }
}
