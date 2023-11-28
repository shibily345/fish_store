import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/pages/detail_page.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                          text: "Betta Fishes",
                          color:
                              Theme.of(context).indicatorColor.withOpacity(0.6),
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
                SizedBox(
                  height: 230,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: productInfo.productInfoList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.5 / 2, // Number of columns
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(productInfo.productInfoList[index].id!);
                          Get.toNamed(AppRouts.getProductDetailPage(
                              productInfo.productInfoList[index].id!));
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
                                    productInfo.productInfoList[index].img!,
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
                                placeholder: (context, url) => const Center(
                                    child: CustomeLoader(
                                  bg: Colors.transparent,
                                )),
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
                                          text: productInfo
                                              .productInfoList[index].name!,
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    textWidget(
                                        text:
                                            '₹ ${productInfo.productInfoList[index].price!} /pair',
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textWidget(
                                        text: productInfo.productInfoList[index]
                                                    .breeder ==
                                                ''
                                            ? "@Devine_Bettas"
                                            : '@${productInfo.productInfoList[index].breeder!}',
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
          : Center(
              child: Container(),
            );
    });
  }
}
