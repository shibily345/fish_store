// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/Pages/domain/models/products_model.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:betta_store/features/Pages/presentation/ads/native_ad.dart';
import 'package:betta_store/features/Pages/presentation/product_detils/widgets/add_cart_button.dart';
import 'package:betta_store/features/products/presentation/all/widgets/recommended_horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/betta_fishes/widgets/horizontal_grid.dart';

import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';

import 'package:betta_store/features/Pages/domain/controller/cart_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/review_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';

import 'package:betta_store/features/Pages/presentation/product_detils/widgets/detile_slides.dart';
import 'package:betta_store/features/Pages/presentation/product_detils/widgets/review_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/core/utils/theme/constants.dart';

class DeskTopProductDetails extends StatefulWidget {
  int pageId;
  DeskTopProductDetails({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  State<DeskTopProductDetails> createState() => _DeskTopProductDetailsState();
}

class _DeskTopProductDetailsState extends State<DeskTopProductDetails> {
  var allProducts = Get.find<ProductInfoController>().productInfoList;
  int pgId = 0;
  ProductModel? thisProduct;
  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    allProducts = Get.find<ProductInfoController>().productInfoList;
    print(
        "Page id:      $pgId     ----------------------------------------------- ");
    if (pgId == 0) {
      pgId = widget.pageId;
    }
    Get.find<ReviewController>().getReview();
    print(
        "Page id:      $pgId     ----------------------------------------------- ");
    thisProduct = allProducts.firstWhere((p) => p.id == pgId);

    Get.find<ProductInfoController>().initNew(
      Get.find<CartController>(),
      thisProduct!,
    );
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Scaffold(
          bottomSheet: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).primaryColorDark,
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // appBar: AppBar(),
          body: Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.39,
              child: DetailSlides(
                productInfo: thisProduct!,
                index: pgId,
              ),
            ),
            _buildDetails(context, thisProduct!)
          ]),
        ),
        AddToCartButton(
          thisProduct: thisProduct!,
        )
      ],
    );
  }

  Container _buildDetails(BuildContext context, ProductModel thisProduct) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
        ),
        // padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: ListView(
          padding: EdgeInsets.zero,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            //     child: Container(
            //       height: 8,
            //       width: 80,
            //       decoration: BoxDecoration(
            //           color: Theme.of(context).scaffoldBackgroundColor,
            //           borderRadius: BorderRadius.circular(4)),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 200.w,
              child: textWidget(
                  text: thisProduct.name!,
                  maxline: 4,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).indicatorColor),
            ),
            textWidget(
                text: '@${thisProduct.breeder!}',
                fontSize: 15,
                color: Theme.of(context).indicatorColor.withOpacity(0.6)),
            smallSpace,
            RatingBarIndicator(
              rating: double.parse(thisProduct.stars!),
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).indicatorColor,
                size: 10,
              ),
              itemSize: 20,
            ),
            smallSpace,
            _buildPriceTag(thisProduct, context),
            SizedBox(
              height: 20.w,
            ),
            kIsWeb
                ? const SizedBox()
                : BannerAdWId(
                    unitIdAndroid: "ca-app-pub-1634533782017400/4085939186"),
            bigSpace,
            textWidget(
                text: 'Description',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).indicatorColor),
            smallSpace,
            textWidget(
                maxline: 20,
                text: thisProduct.description!,
                color: Theme.of(context).indicatorColor.withOpacity(0.7)),
            bigSpace,
            bigSpace,
            textWidget(
                text: 'Reviews',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).indicatorColor),
            smallSpace,
            ReviweBoxWidget(id: pgId),
            bigSpace,
            kIsWeb ? const SizedBox() : BannerAdWId(),
            const RecommendedProductsHorizontalGrid(),
            const BettaFishHorizontalGrid(),
            kIsWeb
                ? const SizedBox()
                : BannerAdWId(
                    unitIdAndroid: "ca-app-pub-1634533782017400/4085939186"),
            bigSpace,
            bigSpace
          ].animate(interval: 100.ms).fade().slideY(curve: Curves.easeInOut),
        ));
  }

  Column _buildPriceTag(ProductModel thisProduct, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        thisProduct.price == 0
            ? Container()
            : RichTextWidget(texts: [
                TextSpan(
                    text: '₹ ${thisProduct.price!}',
                    style: const TextStyle(fontSize: 20)),
                if (thisProduct.typeId == 4 || thisProduct.typeId == 6)
                  TextSpan(
                      text: '/pair',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .indicatorColor
                              .withOpacity(0.4)))
                else
                  TextSpan(
                      text: '/${thisProduct.video}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .indicatorColor
                              .withOpacity(0.4))),
              ]),
        thisProduct.malePrice == 0 ? Container() : smallSpace,
        thisProduct.malePrice == 0
            ? Container()
            : RichTextWidget(texts: [
                TextSpan(
                    text: thisProduct.malePrice == 0
                        ? "No"
                        : '₹ ${thisProduct.malePrice!}',
                    style: const TextStyle(fontSize: 20)),
                TextSpan(
                    text: '/male',
                    style: TextStyle(
                        fontSize: 15,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.4))),
              ]),
        thisProduct.femalePrice == 0 ? Container() : smallSpace,
        thisProduct.femalePrice == 0
            ? Container()
            : RichTextWidget(texts: [
                TextSpan(
                    text: '₹ ${thisProduct.femalePrice!}',
                    style: const TextStyle(fontSize: 20)),
                TextSpan(
                    text: '/femail',
                    style: TextStyle(
                        fontSize: 15,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.4))),
              ]),
      ],
    );
  }
}
