import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/pages/detail_page.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FishesHorizontslGrid extends StatefulWidget {
  const FishesHorizontslGrid({super.key});

  @override
  State<FishesHorizontslGrid> createState() => _FishesHorizontslGridState();
}

class _FishesHorizontslGridState extends State<FishesHorizontslGrid> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherFishInfoController>(
      builder: (
        productInfo,
      ) {
        return productInfo.isLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                              text: "Fishes",
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
                  ProductTileHor(
                      productInfoList: productInfo.otherFishInfoList),
                ],
              )
            : Container();
      },
    );
  }
}
