import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/all_products/presentation/pages/detail_page.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RecomProductHorizontalGrid extends StatefulWidget {
  const RecomProductHorizontalGrid({super.key});

  @override
  State<RecomProductHorizontalGrid> createState() =>
      _RecomProductHorizontalGridState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _RecomProductHorizontalGridState
    extends State<RecomProductHorizontalGrid> {
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];
  @override
  void initState() {
    addAll();
    super.initState();
  }

  Future<void> addAll() async {
    allProducts.addAll(fishes.productInfoList
        .where((product) => product.isRecommended == 1)
        .toList());
    allProducts.addAll(plants.plantsInfoList
        .where((product) => product.isRecommended == 1)
        .toList());
    allProducts.addAll(otherFish.otherFishInfoList
        .where((product) => product.isRecommended == 1)
        .toList());
    allProducts.addAll(items.itemsInfoList
        .where((product) => product.isRecommended == 1)
        .toList());
    allProducts.addAll(feeds.feedsInfoList
        .where((product) => product.isRecommended == 1)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      if (productInfo.isLoaded) {
        return allProducts.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  smallSpace,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 40.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: "Recommended :",
                              color: Theme.of(context)
                                  .indicatorColor
                                  .withOpacity(0.6),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const AllProductPage());
                            },
                            child: textWidget(
                                text: "See all >",
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProductTileHor(productInfoList: allProducts),
                ],
              )
            : Container();
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bigSpace,
              const CustomeLoader(),
              bigSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[700]!,
                  child: Container(
                    height: 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[600]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          width: 190.w,
          height: 250.h,
          margin: EdgeInsets.all(5.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 115.h,
                width: 160.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).splashColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                margin: const EdgeInsets.all(0),
                width: 175.w,
                height: 70.h,
                // decoration: BoxDecoration(
                //   color: Theme.of(context).scaffoldBackgroundColor,
                //   borderRadius: BorderRadius.circular(20),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).splashColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: 100,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
