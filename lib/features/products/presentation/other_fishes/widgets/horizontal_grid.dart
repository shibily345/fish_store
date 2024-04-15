import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/models/products_model.dart';
import 'package:betta_store/features/products/presentation/betta_fishes/pages/detail_page.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/products/presentation/other_fishes/pages/detail_page.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OtherFishesHorizontalGrid extends StatefulWidget {
  const OtherFishesHorizontalGrid({super.key});

  @override
  State<OtherFishesHorizontalGrid> createState() =>
      _OtherFishesHorizontalGridState();
}

class _OtherFishesHorizontalGridState extends State<OtherFishesHorizontalGrid> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      List<dynamic> otherFishes = productInfo.productInfoList
          .where((product) => product.typeId == 6)
          .toList();
      return productInfo.productInfoList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                smallSpace,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 30.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                            text: "Other Fishes",
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.6),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const OtherFishPage());
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
                !productInfo.isLoaded
                    ? ProductTileLoading()
                    : ProductTileHor(productInfoList: otherFishes),
              ],
            )
          : Center(
              child: Container(),
            );
    });
  }
}
