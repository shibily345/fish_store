import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
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

class TopRatedProducts extends StatefulWidget {
  const TopRatedProducts({super.key});

  @override
  State<TopRatedProducts> createState() => _TopRatedProductsState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _TopRatedProductsState extends State<TopRatedProducts> {
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];
  List<dynamic> recProduct = [];
  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);

    super.initState();
  }

  void _sort() {
    allProducts.sort((a, b) => b.people.compareTo(a.people));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      _sort();
      return productInfo.isLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                smallSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 30.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          text: "Popular :",
                          color:
                              Theme.of(context).indicatorColor.withOpacity(0.6),
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
                SizedBox(
                  height: 230,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 15.w),
                    itemCount: recProduct.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.5 / 2, // Number of columns
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(recProduct[index].id!);
                          Get.toNamed(AppRouts.getProductDetailPage(
                              recProduct[index].id!));
                        },
                        child: Container(
                          width: 190.w,
                          height: 250.h,
                          margin: EdgeInsets.all(5.0.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CachedNetworkImage(
                                height: 115.h,
                                width: 160.w,
                                imageUrl: AppConstents.BASE_URL +
                                    AppConstents.UPLOAD_URL +
                                    recProduct[index].img!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                    const Icon(Icons.error),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                margin: const EdgeInsets.all(10),
                                width: 175.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120.w,
                                      child: textWidget(
                                          text: recProduct[index].name!,
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    textWidget(
                                        text:
                                            '₹ ${recProduct[index].price!} /pair',
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textWidget(
                                        text: recProduct[index].breeder == ''
                                            ? "@Devine_Bettas"
                                            : '@${recProduct[index].breeder!}',
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: CustomeLoader(),
            );
    });
  }
}
