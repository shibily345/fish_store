import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BettaFishGrid extends StatefulWidget {
  const BettaFishGrid({super.key});

  @override
  State<BettaFishGrid> createState() => _BettaFishGridState();
}

enum SortOption { newest, priceHighToLow, priceLowToHigh, oldest }

class _BettaFishGridState extends State<BettaFishGrid> {
  SortOption _selectedSortOption = SortOption.newest;
  Future<void> _loadResources() async {
    _selectedSortOption = SortOption.newest;
    await Get.find<ProductInfoController>().getProductInfoList();
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
              productInfo.productInfoList
                  .sort((a, b) => b.price.compareTo(a.price));
              break;
            case SortOption.priceLowToHigh:
              productInfo.productInfoList
                  .sort((a, b) => a.price.compareTo(b.price));
              break;
            case SortOption.newest:
              productInfo.productInfoList
                  .sort((a, b) => b.createdAt.compareTo(a.createdAt));
              break;
            case SortOption.oldest:
              productInfo.productInfoList
                  .sort((a, b) => a.createdAt.compareTo(b.createdAt));
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
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: productInfo.productInfoList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5, // Number of columns
                ),
                itemBuilder: (context, index) {
                  return ProductTileGrid(
                      productInfoList: productInfo.productInfoList,  
                      index: index);
                },
              ),
            ),
          ].animate(interval: 300.ms).fade().fadeIn(curve: Curves.easeInOut),
        ),
      );
    });
  }
}
