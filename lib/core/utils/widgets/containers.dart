// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BlurContainer extends StatelessWidget {
  BlurContainer({
    this.radius = 15,
    this.color = const Color.fromARGB(255, 169, 169, 169),
    this.padding = EdgeInsets.zero,
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  Color color;
  final EdgeInsets padding;
  final double radius;
  final Widget child;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: color.withOpacity(0.2),
              child: child,
            ),
          )),
    );
  }
}

class AmbiendContainer extends StatelessWidget {
  AmbiendContainer({
    this.radius = 15,
    this.color = const Color.fromARGB(255, 169, 169, 169),
    this.padding = EdgeInsets.zero,
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  Color color;
  final EdgeInsets padding;
  final double radius;
  final Widget child;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: color,
              child: child,
            ),
          )),
    );
  }
}

class BlurImageContainer extends StatelessWidget {
  BlurImageContainer({
    this.radius = 15,
    this.color = Colors.white,
    this.padding = EdgeInsets.zero,
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    required this.image,
  }) : super(key: key);
  final String image;
  Color color;
  final EdgeInsets padding;
  final double radius;
  final Widget child;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.black.withOpacity(0.6),
              child: child,
            ),
          )),
    );
  }
}

class ContainerPage extends StatelessWidget {
  final Widget widget;

  const ContainerPage({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: widget);
  }
}

class BrickGridViewDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  final double offset;

  const BrickGridViewDelegate({
    required int crossAxisCount,
    required double offset,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    required SliverConstraints mySliverConstraints,
  })  : offset = offset,
        super(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio);

  @override
  SliverConstraints mySliverConstraints(SliverConstraints constraints) {
    return SliverConstraints(
      axisDirection: constraints.axisDirection,
      growthDirection: constraints.growthDirection,
      userScrollDirection: constraints.userScrollDirection,
      scrollOffset: constraints.scrollOffset,
      precedingScrollExtent: constraints.precedingScrollExtent,
      overlap: constraints.overlap,
      remainingPaintExtent: constraints.remainingPaintExtent,
      crossAxisExtent: constraints.crossAxisExtent,
      crossAxisDirection: constraints.crossAxisDirection,
      viewportMainAxisExtent: constraints.viewportMainAxisExtent,
      remainingCacheExtent: constraints.remainingCacheExtent,
      cacheOrigin: constraints.cacheOrigin,
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegateWithFixedCrossAxisCount oldDelegate) {
    return offset != oldDelegate.mainAxisSpacing;
  }
}

class ProductTileHor extends StatelessWidget {
  const ProductTileHor({
    Key? key,
    required this.productInfoList,
  }) : super(key: key);
  final dynamic productInfoList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 10.w),
        itemCount: productInfoList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.5 / 2, // Number of columns
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                  AppRouts.getProductDetailPage(productInfoList[index].id!));
            },
            child: Container(
              margin: EdgeInsets.all(5.0.h),
              decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 130.h,
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: CachedNetworkImage(
                      imageUrl: AppConstents.BASE_URL +
                          AppConstents.UPLOAD_URL +
                          productInfoList[index].img!,
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
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      margin: const EdgeInsets.all(10),
                      // height: 70.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            //width: 120.w,
                            child: textWidget(
                                text: productInfoList[index].name!,
                                color: Theme.of(context).indicatorColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          textWidget(
                              text: '₹ ${productInfoList[index].price!} /pair',
                              color: Theme.of(context).indicatorColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          textWidget(
                              text: '@${productInfoList[index].breeder!}',
                              color: Theme.of(context).indicatorColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductTileGrid extends StatelessWidget {
  ProductTileGrid({
    Key? key,
    required this.productInfoList,
    required this.index,
  }) : super(key: key);
  final dynamic productInfoList;
  int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouts.getProductDetailPage(productInfoList[index].id!));
      },
      child: Container(
        margin: EdgeInsets.all(5.0.h),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 110.h,
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: CachedNetworkImage(
                imageUrl: AppConstents.BASE_URL +
                    AppConstents.UPLOAD_URL +
                    productInfoList[index].img!,
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                margin: const EdgeInsets.all(10),
                // height: 70.h,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      //width: 120.w,
                      child: textWidget(
                          text: productInfoList[index].name!,
                          color: Theme.of(context).indicatorColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    textWidget(
                        text: '₹ ${productInfoList[index].price!} /pair',
                        color: Theme.of(context).indicatorColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    textWidget(
                        text: '@${productInfoList[index].breeder!}',
                        color: Theme.of(context).indicatorColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ].animate(interval: 200.ms).fade().slideY(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
