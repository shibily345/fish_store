// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/presentation/home/Shop/shop_cart.dart';
import 'package:betta_store/presentation/home/home_screen.dart';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/presentation/product_detils/detile_slides.dart';
import 'package:betta_store/utils/theme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/controller/product_info_controller.dart';

class OtherFishDetilsPage extends StatefulWidget {
  int pageId;
  OtherFishDetilsPage({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  State<OtherFishDetilsPage> createState() => _OtherFishDetilsPageState();
}

class _OtherFishDetilsPageState extends State<OtherFishDetilsPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  bool _expanded = false;
  bool _ownExpanded = false;
  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      _ownExpanded = false;
    });
  }

  void _toggleOwnExpanded() {
    setState(() {
      _ownExpanded = !_ownExpanded;
      _expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var product = Get.find<OtherFishInfoController>()
        .otherFishInfoList
        .firstWhere((p) => p.id == widget.pageId);

    Get.find<OtherFishInfoController>().initNew(
      Get.find<CartController>(),
      product,
    );
    return Stack(
      children: [
        Scaffold(
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
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.menu_1),
                    ),
                    expandedHeight: 655.h,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    toolbarHeight: 65.h,
                    // floating: true,
                    automaticallyImplyLeading: false,
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
                    bottom: PreferredSize(
                      preferredSize: Size(100.w, 80.h),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 35.0.w, bottom: 15.h),
                            child: textWidget(
                                text: product.name!,
                                fontSize: 16,
                                color: Theme.of(context).indicatorColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlurContainer(
                          width: Get.width.w,
                          height: 100.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichTextWidget(texts: [
                                const TextSpan(text: 'Pair : \n       \n'),
                                TextSpan(
                                    text: '₹ ${product.price!}',
                                    style: const TextStyle(fontSize: 20))
                              ]),
                              RichTextWidget(texts: const [
                                TextSpan(text: 'Male : \n       \n'),
                                TextSpan(
                                    text: '₹ 200',
                                    style: TextStyle(fontSize: 20))
                              ]),
                              RichTextWidget(texts: const [
                                TextSpan(text: 'Female : \n       \n'),
                                TextSpan(
                                    text: '₹ 100',
                                    style: TextStyle(fontSize: 20))
                              ])
                            ],
                          )),
                      SizedBox(
                        height: 20.w,
                      ),
                      textWidget(
                          text: '@devine_Bettas',
                          color: Theme.of(context).indicatorColor),
                      SizedBox(
                        height: 60.w,
                      ),
                      textWidget(
                          maxline: 20,
                          text: product.description!,
                          color: Theme.of(context).indicatorColor),
                    ],
                  ))),
        ),
        GetBuilder<OtherFishInfoController>(builder: (productInfo) {
          double totel =
              (product.price!.toDouble() * productInfo.quantity.toDouble()) +
                  (200 * productInfo.maleQuantity.toDouble()) +
                  (100 * productInfo.feQuantity.toDouble());
          productInfo.getPrice(totel);
          return Positioned(
            bottom: 20,
            right: 15,
            child: Row(
              children: [
                GestureDetector(
                  onTap: productInfo.exist
                      ? () {
                          Get.toNamed(AppRouts.cartPage);
                        }
                      : _toggleExpanded,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _expanded ? 280.0.h : 50.0,
                    width: _expanded ? 190.0.w : 190.0.w,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(1.5, 1.5),
                            // shadow direction: bottom right
                          )
                        ],
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(40.h)),
                    child: _expanded
                        ? SizedBox(
                            height: 290.h,
                            width: 180.w,
                            child: ListView(
                              children: [
                                Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0.w),
                                        child: textWidget(
                                            text: "Pair",
                                            fontSize: 12,
                                            color: secondaryColor60DarkTheme,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setQuantity(false);
                                        },
                                        icon: Icon(
                                          Iconsax.minus_cirlce,
                                          color: Colors.black,
                                          size: ScreenUtil().setSp(18),
                                        ),
                                      ),
                                      textWidget(
                                          text:
                                              productInfo.quantity.toString()),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setQuantity(true);
                                        },
                                        icon: Icon(
                                          Iconsax.add_circle,
                                          color: Colors.black,
                                          size: ScreenUtil().setSp(18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
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
                                            color: secondaryColor60DarkTheme,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setmaleQuantity(false);
                                        },
                                        icon: Icon(
                                          Iconsax.minus_cirlce,
                                          color: Colors.black,
                                          size: ScreenUtil().setSp(18),
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
                                          size: ScreenUtil().setSp(18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
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
                                            color: secondaryColor60DarkTheme,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setfeQuantity(false);
                                        },
                                        icon: Icon(
                                          Iconsax.minus_cirlce,
                                          color: Colors.black,
                                          size: ScreenUtil().setSp(18),
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
                                          size: ScreenUtil().setSp(18),
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
                                        horizontal: 15.0),
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
                                                productInfo.addItem(product);
                                                productInfo.exist
                                                    ? ()
                                                    : _toggleExpanded();
                                              },
                                              icon: const Icon(
                                                color:
                                                    secondaryColor80DarkTheme,
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
                            ),
                          )
                        : Center(
                            child: textWidget(
                                text: productInfo.exist
                                    ? "Check it out "
                                    : "Put in bag",
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
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
