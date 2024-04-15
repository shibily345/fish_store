import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/models/products_model.dart';
import 'package:betta_store/features/products/presentation/betta_fishes/pages/detail_page.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BettaFishHorizontalGrid extends StatefulWidget {
  const BettaFishHorizontalGrid({super.key});

  @override
  State<BettaFishHorizontalGrid> createState() =>
      _BettaFishHorizontalGridState();
}

class _BettaFishHorizontalGridState extends State<BettaFishHorizontalGrid> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      List<dynamic> bettaFishes = productInfo.productInfoList
          .where((product) => product.typeId == 4)
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
                            text: "Betta Fishes",
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.6),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const BettaFishPage());
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
                    : ProductTileHor(productInfoList: bettaFishes)
              ],
            )
          : Center(
              child: Container(),
            );
    });
  }
}
