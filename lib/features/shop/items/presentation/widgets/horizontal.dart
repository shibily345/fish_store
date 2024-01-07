import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
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
                  ProductTileHor(productInfoList: productInfo.itemsInfoList),
                ],
              )
            : Container();
      },
    );
  }
}
