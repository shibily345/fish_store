import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/pages/detail_page.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ItemsHorizontalGrid extends StatefulWidget {
  const ItemsHorizontalGrid({super.key});

  @override
  State<ItemsHorizontalGrid> createState() => _ItemsHorizontalGridState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _ItemsHorizontalGridState extends State<ItemsHorizontalGrid> {
  SortOption _selectedSortOption = SortOption.newest;
  Future<void> _loadResources() async {
    _selectedSortOption = SortOption.newest;
    await Get.find<ItemsInfoController>().getItemsInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemsInfoController>(
      builder: (
        productInfo,
      ) {
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
                    height: 40.h,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: "Aquarium essentials",
                              color: Theme.of(context)
                                  .indicatorColor
                                  .withOpacity(0.6),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ItemsPage());
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
                  SizedBox(
                    height: 230,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15.w),
                      itemCount: productInfo.itemsInfoList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 2.5 / 2, // Number of columns
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouts.getProductDetailPage(
                                productInfo.itemsInfoList[index].id!));
                          },
                          child: Container(
                            width: 190.w,
                            height: 250.h,
                            margin: const EdgeInsets.all(5.0),
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
                                      productInfo.itemsInfoList[index].img!,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  margin: const EdgeInsets.all(10),
                                  width: 175.w,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        child: textWidget(
                                            text: productInfo
                                                .itemsInfoList[index].name!,
                                            color: Theme.of(context)
                                                .indicatorColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      textWidget(
                                          text:
                                              '₹ ${productInfo.itemsInfoList[index].price!} /-',
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      textWidget(
                                          text: productInfo.itemsInfoList[index]
                                                      .breeder ==
                                                  ''
                                              ? "@Devine_Bettas"
                                              : '@${productInfo.itemsInfoList[index].breeder!}',
                                          color:
                                              Theme.of(context).indicatorColor,
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
            : Container();
      },
    );
  }
}
