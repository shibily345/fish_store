import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
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

class AllProductGrid extends StatefulWidget {
  const AllProductGrid({super.key});

  @override
  State<AllProductGrid> createState() => _AllProductGridState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _AllProductGridState extends State<AllProductGrid> {
  SortOption _selectedSortOption = SortOption.newest;
  Future<void> _loadResources() async {
    _selectedSortOption = SortOption.newest;
    await Get.find<ProductInfoController>().getProductInfoList();
  }

  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      void _sortData(SortOption selectedOption) {
        setState(() {
          switch (selectedOption) {
            case SortOption.priceHighToLow:
              allProducts.sort((a, b) => b.price.compareTo(a.price));
              break;
            case SortOption.priceLowToHigh:
              allProducts.sort((a, b) => a.price.compareTo(b.price));
              break;
            case SortOption.newest:
              allProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              break;
            case SortOption.oldest:
              allProducts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
              break;
          }
        });
      }

      return RefreshIndicator(
        onRefresh: _loadResources,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smallSpace,
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: SizedBox(
                height: 35.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: SortOption.values.map((SortOption option) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSortOption = option;
                          _sortData(_selectedSortOption);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          // height: 10,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _selectedSortOption == option
                                ? Theme.of(context).splashColor
                                : Theme.of(context)
                                    .splashColor
                                    .withOpacity(0.4),
                          ),
                          child: Center(
                            child: textWidget(
                              text: option.toString().split('.').last,
                              color: _selectedSortOption == option
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).indicatorColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: allProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5, // Number of columns
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(allProducts[index].id!);
                      Get.toNamed(AppRouts.getProductDetailPage(
                          allProducts[index].id!));
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
                            height: 105.h,
                            width: 160.w,
                            imageUrl: AppConstents.BASE_URL +
                                AppConstents.UPLOAD_URL +
                                allProducts[index].img!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[700]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120.w,
                                  child: textWidget(
                                      text: allProducts[index].name!,
                                      color: Theme.of(context).indicatorColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                textWidget(
                                    text:
                                        '₹ ${allProducts[index].price!} /pair',
                                    color: Theme.of(context).indicatorColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                textWidget(
                                    text: allProducts[index].breeder == ''
                                        ? "@Devine_Bettas"
                                        : '@${allProducts[index].breeder!}',
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
        ),
      );
    });
  }
}
