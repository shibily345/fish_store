// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/Pages/domain/models/products_model.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:betta_store/features/Pages/presentation/product_detils/widgets/add_cart_button.dart';
import 'package:betta_store/features/products/presentation/all/widgets/recommended_horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/betta_fishes/widgets/horizontal_grid.dart';

import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';

import 'package:betta_store/features/Pages/domain/controller/cart_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/review_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';

import 'package:betta_store/features/Pages/presentation/product_detils/widgets/detile_slides.dart';
import 'package:betta_store/features/Pages/presentation/product_detils/widgets/review_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/core/utils/theme/constants.dart';

class FishDetilsPage extends StatefulWidget {
  int pageId;
  FishDetilsPage({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  State<FishDetilsPage> createState() => _FishDetilsPageState();
}

class _FishDetilsPageState extends State<FishDetilsPage> {
  var allProducts = Get.find<ProductInfoController>().productInfoList;
  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);

    Get.find<ReviewController>().getReview();
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
    ProductModel thisProduct =
        allProducts.firstWhere((p) => p.id == widget.pageId);

    Get.find<ProductInfoController>().initNew(
      Get.find<CartController>(),
      thisProduct,
    );

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
          body: NestedScrollView(
              clipBehavior: Clip.antiAlias,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxScrolled,
              ) {
                return <Widget>[
                  SliverAppBar.large(
                    expandedHeight: 520.h,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    toolbarHeight: 65.h,
                    floating: true,
                    automaticallyImplyLeading: true,
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/bstore logos/labelWhite.png',
                        width: 150.w,
                        height: 50.h,
                      ),
                    ),
                    flexibleSpace: LayoutBuilder(builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) {
                      return FlexibleSpaceBar(
                          background: DetailSlides(
                        productInfo: thisProduct,
                        index: widget.pageId,
                      ));
                    }),
                  )
                ];
              },
              body: Container(
                  //  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  // padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                          child: Container(
                            height: 8,
                            width: 80,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: textWidget(
                                  text: thisProduct.name!,
                                  maxline: 4,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).indicatorColor),
                            ),
                            RatingBarIndicator(
                              rating: double.parse(thisProduct.stars!),
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Theme.of(context).indicatorColor,
                                size: 10,
                              ),
                              itemSize: 20,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(
                                text: '@${thisProduct.breeder!}',
                                fontSize: 15,
                                color: Theme.of(context)
                                    .indicatorColor
                                    .withOpacity(0.6)),
                            textWidget(
                                text: '(New)',
                                fontSize: 13,
                                color: Theme.of(context)
                                    .indicatorColor
                                    .withOpacity(0.3)),
                          ],
                        ),
                      ),
                      smallSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            thisProduct.price == 0
                                ? Container()
                                : RichTextWidget(texts: [
                                    TextSpan(
                                        text: '₹ ${thisProduct.price!}',
                                        style: const TextStyle(fontSize: 20)),
                                    if (thisProduct.typeId == 4 ||
                                        thisProduct.typeId == 6)
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
                            smallSpace,
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
                                            color: Theme.of(context)
                                                .indicatorColor
                                                .withOpacity(0.4))),
                                  ]),
                            smallSpace,
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
                                            color: Theme.of(context)
                                                .indicatorColor
                                                .withOpacity(0.4))),
                                  ]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      bigSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: textWidget(
                            text: 'Description',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).indicatorColor),
                      ),
                      smallSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: textWidget(
                            maxline: 20,
                            text: thisProduct.description!,
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.7)),
                      ),
                      bigSpace,
                      bigSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: textWidget(
                            text: 'Reviews',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).indicatorColor),
                      ),
                      smallSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: ReviweBoxWidget(id: widget.pageId),
                      ),
                      bigSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: BannerAdWId(),
                      ),
                      const RecommendedProductsHorizontalGrid(),
                      const BettaFishHorizontalGrid(),
                      bigSpace,
                      bigSpace
                    ]
                        .animate(interval: 100.ms)
                        .fade()
                        .slideY(curve: Curves.easeInOut),
                  ))),
        ),
        AddToCartButton(
          thisProduct: thisProduct,
        )
      ],
    );
  }
}
