import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/items_info_controller.dart';
import 'package:betta_store/infrastructure/controller/feeds_info_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/data/repository/product_info_repo.dart';
import 'package:betta_store/infrastructure/models/feeds_detile_model.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/infrastructure/models/items_detile_model.dart';
import 'package:betta_store/infrastructure/models/other_fish_detile_model.dart';
import 'package:betta_store/infrastructure/models/plant_detile_model.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/loading.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/presentation/home/home_screen.dart';
import 'package:betta_store/presentation/product_detils/detile_screen.dart';
import 'package:betta_store/utils/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key, required this.tabcontroller});
  final TabController tabcontroller;
  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  Future<void> _loadResources() async {
    await Get.find<ProductInfoController>().getProductInfoList();
    await Get.find<PlantsInfoController>().getPlantsInfoList();
    await Get.find<OtherFishInfoController>().getOtherFishInfoList();
    await Get.find<ItemsInfoController>().getItemsInfoList();
    await Get.find<FeedsInfoController>().getfeedsInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      return productInfo.isLoaded
          ? DefaultTabController(
              length: 5,
              child: TabBarView(controller: widget.tabcontroller, children: [
                RefreshIndicator(
                  onRefresh: _loadResources,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: productInfo.productInfoList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 3.0,
                      crossAxisSpacing: 3.0,
                    ),
                    itemBuilder: (context, index) {
                      return shopItems(
                        productInfo,
                        index,
                        productInfo.productInfoList[index],
                      );
                    },
                  ),
                ),
                GetBuilder<PlantsInfoController>(
                  builder: (
                    productInfo,
                  ) {
                    return productInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productInfo.plantsInfoList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouts.getPlantDetails(index));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        productInfo
                                                            .plantsInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  255, 226, 226, 226),
                                              Color.fromARGB(255, 255, 213, 0)
                                            ], // List of colors in the gradient
                                            begin: Alignment
                                                .topLeft, // Starting point of the gradient
                                            end: Alignment
                                                .bottomRight, // Ending point of the gradient
                                            stops: [
                                              0.0,
                                              1.0
                                            ], // Stops for each color in the gradient
                                            // You can also use `TileMode` to control how the gradient is repeated
                                            tileMode: TileMode
                                                .clamp, // This will repeat the gradient to fill the container
                                          ),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: productInfo
                                                      .plantsInfoList[index]
                                                      .name!,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: CustomeLoader(),
                          );
                  },
                ),
                GetBuilder<OtherFishInfoController>(
                  builder: (
                    ofProductInfo,
                  ) {
                    return ofProductInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: ofProductInfo.otherFishInfoList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouts.getOtherFishDetails(
                                                  index));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        ofProductInfo
                                                            .otherFishInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  255, 226, 226, 226),
                                              Color.fromARGB(255, 255, 213, 0)
                                            ], // List of colors in the gradient
                                            begin: Alignment
                                                .topLeft, // Starting point of the gradient
                                            end: Alignment
                                                .bottomRight, // Ending point of the gradient
                                            stops: [
                                              0.0,
                                              1.0
                                            ], // Stops for each color in the gradient
                                            // You can also use `TileMode` to control how the gradient is repeated
                                            tileMode: TileMode
                                                .clamp, // This will repeat the gradient to fill the container
                                          ),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: ofProductInfo
                                                      .otherFishInfoList[index]
                                                      .name!,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : CustomeLoader();
                  },
                ),
                GetBuilder<ItemsInfoController>(
                  builder: (
                    productInfo,
                  ) {
                    return productInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productInfo.itemsInfoList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouts.getItemsDetails(index));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        productInfo
                                                            .itemsInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  255, 226, 226, 226),
                                              Color.fromARGB(255, 255, 213, 0)
                                            ], // List of colors in the gradient
                                            begin: Alignment
                                                .topLeft, // Starting point of the gradient
                                            end: Alignment
                                                .bottomRight, // Ending point of the gradient
                                            stops: [
                                              0.0,
                                              1.0
                                            ], // Stops for each color in the gradient
                                            // You can also use `TileMode` to control how the gradient is repeated
                                            tileMode: TileMode
                                                .clamp, // This will repeat the gradient to fill the container
                                          ),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: productInfo
                                                      .itemsInfoList[index]
                                                      .name!,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : CustomeLoader();
                  },
                ),
                GetBuilder<FeedsInfoController>(
                  builder: (
                    productInfo,
                  ) {
                    return productInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productInfo.feedsInfoList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouts.getFeedsDetail(index));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        productInfo
                                                            .feedsInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  255, 226, 226, 226),
                                              Color.fromARGB(255, 255, 213, 0)
                                            ], // List of colors in the gradient
                                            begin: Alignment
                                                .topLeft, // Starting point of the gradient
                                            end: Alignment
                                                .bottomRight, // Ending point of the gradient
                                            stops: [
                                              0.0,
                                              1.0
                                            ], // Stops for each color in the gradient
                                            // You can also use `TileMode` to control how the gradient is repeated
                                            tileMode: TileMode
                                                .clamp, // This will repeat the gradient to fill the container
                                          ),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: productInfo
                                                      .feedsInfoList[index]
                                                      .name!,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : CustomeLoader();
                  },
                ),
              ]),
            )
          : Center(
              child: CustomeLoader(),
            );
    });
  }

  Stack shopItems(
      ProductInfoController productInfo, int index, ProductModel products) {
    return Stack(
      //   fit: StackFit.loose,
      children: [
        Container(
          width: 190.w,
          height: 190.h,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // color: Color.fromARGB(236, 217, 16, 16),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              bigSpace,
              bigSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    //padding: EdgeInsets.only(top: 40, left: 20),
                    width: 177.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Color.fromARGB(255, 226, 226, 226),
                      //     Color.fromARGB(255, 255, 213, 0)
                      //   ], // List of colors in the gradient
                      //   begin:
                      //       Alignment.topLeft, // Starting point of the gradient
                      //   end: Alignment
                      //       .bottomRight, // Ending point of the gradient
                      //   stops: [
                      //     0.0,
                      //     1.0
                      //   ], // Stops for each color in the gradient
                      //   // You can also use `TileMode` to control how the gradient is repeated
                      //   tileMode: TileMode
                      //       .clamp, // This will repeat the gradient to fill the container
                      // ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.elliptical(180, 160),
                          topLeft: Radius.elliptical(180, 160)),
                    ),
                  ),
                  // SizedBox(width: 40.w),
                  // textWidget(
                  //     text: "Pair : ₹ ",
                  //     color: secondaryColor40DarkTheme),
                  // textWidget(
                  //     text: "300",
                  //     color: secondaryColor20DarkTheme,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold)
                ],
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: CircleAvatar(
              backgroundColor: secondaryColor80DarkTheme,
              child: IconButton(
                  enableFeedback: true,
                  onPressed: () {
                    Get.toNamed(AppRouts.getfishDetails(index));
                  },
                  icon: Icon(Iconsax.shopping_cart)),
            )),
        Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              backgroundColor: secondaryColor80DarkTheme,
              child: IconButton(
                  enableFeedback: true,
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border)),
            )),
        Positioned(
          bottom: 20.h,
          left: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 120.w,
                child: textWidget(
                    text: products.name!,
                    color: Theme.of(context).indicatorColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              textWidget(
                  text: "@Devine_Bettas",
                  color: Theme.of(context).indicatorColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w300),
            ],
          ),
        ),
        Positioned(
          //top: 10,
          left: 20,
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRouts.getfishDetails(index));
            },
            child: Image.network(
              AppConstents.BASE_URL + AppConstents.UPLOAD_URL + products.img!,
              width: 150.w,
              height: 150.h,
            ),
          ),
        ),
        // Positioned(
        //   top: 50,
        //   right: 20,
        //   child: IconButton.filled(
        //     onPressed: () {},
        //     icon: Icon(
        //       Iconsax.heart,
        //       color: Theme.of(context).indicatorColor,
        //     ),
        //     highlightColor: Colors.red,
        //   ),
        // ),
        // Positioned(
        //   top: 150,
        //   right: 20,
        //   child: FloatingActionButton.small(
        //     child: Icon(Iconsax.bag_2),
        //     onPressed: () {},
        //   ),
        // )
      ],
    );
  }
}
