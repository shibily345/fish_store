// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';

import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/features/store/domain/controller/review_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:betta_store/features/store/domain/models/review_model.dart';
import 'package:betta_store/features/store/presentation/product_detils/widgets/review_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/product_detils/widgets/detile_slides.dart';
import 'package:betta_store/core/utils/theme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];

  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
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
    var product = allProducts.firstWhere((p) => p.id == widget.pageId);

    Get.find<ProductInfoController>().initNew(
      Get.find<CartController>(),
      product,
    );
    int femaleOfPrice = product.femalePrice == '' ? 0 : product.femalePrice!;
    int maleOfPrice = product.malePrice == '' ? 0 : product.malePrice!;
    return Stack(
      children: [
        Scaffold(
          bottomSheet: Container(
            height: 90,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).shadowColor,
                  Colors.transparent, Colors.transparent,
                  // Replace with your desired color
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
                        productInfo: product,
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
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200.w,
                            child: textWidget(
                                text: product.name!,
                                maxline: 4,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).indicatorColor),
                          ),
                          RatingBarIndicator(
                            rating: double.parse(product.stars.toString()),
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context).indicatorColor,
                              size: 10,
                            ),
                            itemSize: 20,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: '@${product.breeder!}',
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
                      smallSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          product.price == 0
                              ? Container()
                              : RichTextWidget(texts: [
                                  TextSpan(
                                      text: '₹ ${product.price!}',
                                      style: const TextStyle(fontSize: 20)),
                                  if (product.typeId == 4 ||
                                      product.typeId == 6)
                                    TextSpan(
                                        text: '/pair',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .indicatorColor
                                                .withOpacity(0.4)))
                                  else
                                    TextSpan(
                                        text: '/${product.video}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .indicatorColor
                                                .withOpacity(0.4))),
                                ]),
                          smallSpace,
                          product.malePrice == 0
                              ? Container()
                              : RichTextWidget(texts: [
                                  TextSpan(
                                      text: product.malePrice == 0
                                          ? "No"
                                          : '₹ ${product.malePrice!}',
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
                          product.femalePrice == 0
                              ? Container()
                              : RichTextWidget(texts: [
                                  TextSpan(
                                      text: '₹ ${product.femalePrice!}',
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
                      SizedBox(
                        height: 20.w,
                      ),
                      Divider(),
                      bigSpace,
                      textWidget(
                          text: 'Description',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).indicatorColor),
                      smallSpace,
                      textWidget(
                          maxline: 20,
                          text: product.description!,
                          color: Theme.of(context)
                              .indicatorColor
                              .withOpacity(0.7)),
                      Divider(),
                      bigSpace,
                      bigSpace,
                      textWidget(
                          text: 'Reviews',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).indicatorColor),
                      smallSpace,
                      ReviweBoxWidget(id: widget.pageId),
                      bigSpace,
                      bigSpace,
                      bigSpace
                    ],
                  ))),
        ),
        GetBuilder<ProductInfoController>(builder: (productInfo) {
          double totel =
              (product.price!.toDouble() * productInfo.quantity.toDouble()) +
                  (maleOfPrice * productInfo.maleQuantity.toDouble()) +
                  (femaleOfPrice * productInfo.feQuantity.toDouble());
          productInfo.getPrice(totel);
          return Positioned(
            bottom: 20,
            right: 15,
            child: Row(
              children: [
                GestureDetector(
                  onTap: productInfo.exist
                      ? () {
                          Get.toNamed(AppRouts.getCartPage());
                        }
                      : _toggleExpanded,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    // height: _expanded ? 280.0.h : 50.0,
                    width: _expanded ? 230.0.w : 230.0.w,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(1.5, 1.5),
                            // shadow direction: bottom right
                          )
                        ],
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(40.h)),
                    child: _expanded
                        ? ListView(
                            shrinkWrap: true,
                            children: [
                              product.price == 0
                                  ? Container()
                                  : Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0.w),
                                            child: product.typeId == 4 ||
                                                    product.typeId == 6
                                                ? textWidget(
                                                    text: "Pair",
                                                    fontSize: 12,
                                                    color:
                                                        secondaryColor60DarkTheme,
                                                    fontWeight: FontWeight.w600)
                                                : textWidget(
                                                    text: product.video,
                                                    fontSize: 12,
                                                    color:
                                                        secondaryColor60DarkTheme,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              productInfo.setQuantity(false);
                                            },
                                            icon: Icon(
                                              Iconsax.minus_cirlce,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                          textWidget(
                                              text: productInfo.quantity
                                                  .toString()),
                                          IconButton(
                                            onPressed: () {
                                              productInfo.setQuantity(true);
                                            },
                                            icon: Icon(
                                              Iconsax.add_circle,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              maleOfPrice == 0
                                  ? Container()
                                  : Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: textWidget(
                                                text: "Male",
                                                fontSize: 12,
                                                color:
                                                    secondaryColor60DarkTheme,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              productInfo
                                                  .setmaleQuantity(false);
                                            },
                                            icon: Icon(
                                              Iconsax.minus_cirlce,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                          textWidget(
                                              text: productInfo.maleQuantity
                                                  .toString()),
                                          IconButton(
                                            onPressed: () {
                                              productInfo.setmaleQuantity(true);
                                            },
                                            icon: Icon(
                                              Iconsax.add_circle,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              femaleOfPrice == 0
                                  ? Container()
                                  : Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.0.w),
                                            child: textWidget(
                                                text: "Female",
                                                fontSize: 12,
                                                color:
                                                    secondaryColor60DarkTheme,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              productInfo.setfeQuantity(false);
                                            },
                                            icon: Icon(
                                              Iconsax.minus_cirlce,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                          textWidget(
                                              text: productInfo.feQuantity
                                                  .toString()),
                                          IconButton(
                                            onPressed: () {
                                              productInfo.setfeQuantity(true);
                                            },
                                            icon: Icon(
                                              Iconsax.add_circle,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(text: "Tot : ₹ $totel "),
                                      CircleAvatar(
                                        radius: 25,
                                        child: IconButton(
                                            onPressed: () {
                                              print(productInfo.exist);
                                              String token =
                                                  Get.find<UserInfoController>()
                                                      .userModel
                                                      .fcmToken!;

                                              NotificationHelper.sendPushNotification(
                                                  token,
                                                  "${product.name!} added to cart Successfully Worth of $totel",
                                                  "Successsfully added to cart");
                                              productInfo.addItem(
                                                  product, totel);
                                              productInfo.exist
                                                  ? ()
                                                  : _toggleExpanded();
                                            },
                                            icon: const Icon(
                                              color: secondaryColor80DarkTheme,
                                              Iconsax.login_1,
                                              size: 30,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Center(
                            child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: textWidget(
                                text: productInfo.exist
                                    ? "Check it out "
                                    : "Put in bag",
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
