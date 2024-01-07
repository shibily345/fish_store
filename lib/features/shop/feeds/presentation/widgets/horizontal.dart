import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/pages/detail_page.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FeedsHorizontalGrid extends StatefulWidget {
  const FeedsHorizontalGrid({super.key});

  @override
  State<FeedsHorizontalGrid> createState() => _FeedsHorizontalGridState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _FeedsHorizontalGridState extends State<FeedsHorizontalGrid> {
  final SortOption _selectedSortOption = SortOption.newest;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedsInfoController>(
      builder: (
        productInfo,
      ) {
        return productInfo.isLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: "Feeds",
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.6),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const FeedsFishPage());
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
                  ProductTileHor(productInfoList: productInfo.feedsInfoList),
                ],
              )
            : const CustomeLoader();
      },
    );
  }
}
