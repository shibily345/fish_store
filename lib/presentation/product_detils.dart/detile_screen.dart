// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/helper/dependencies.dart';
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
import 'package:betta_store/presentation/product_detils.dart/detile_slides.dart';
import 'package:betta_store/utils/theme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/controller/product_info_controller.dart';

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
    var product =
        Get.find<ProductInfoController>().productInfoList[widget.pageId];
    Get.find<ProductInfoController>().initNew(
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
                      icon: Icon(Iconsax.menu_1),
                    ),
                    expandedHeight: 625.h,
                    backgroundColor: secondaryColor80DarkTheme,
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
                      preferredSize: Size(100.w, 60.h),
                      child: Container(
                        color: secondaryColor80DarkTheme,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: textWidget(
                                text: product.name!,
                                fontSize: 16,
                                color: Colors.white),
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
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlurContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichTextWidget(texts: [
                                TextSpan(text: 'Pair : \n       \n'),
                                TextSpan(
                                    text: '₹ ${product.price!}',
                                    style: TextStyle(fontSize: 20))
                              ]),
                              RichTextWidget(texts: [
                                TextSpan(text: 'Male : \n       \n'),
                                TextSpan(
                                    text: '₹ 200',
                                    style: TextStyle(fontSize: 20))
                              ]),
                              RichTextWidget(texts: [
                                TextSpan(text: 'Female : \n       \n'),
                                TextSpan(
                                    text: '₹ 100',
                                    style: TextStyle(fontSize: 20))
                              ])
                            ],
                          ),
                          width: Get.width.w,
                          height: 100.h),
                      SizedBox(
                        height: 20.w,
                      ),
                      textWidget(text: '@devine_Bettas', color: Colors.white),
                      SizedBox(
                        height: 60.w,
                      ),
                      textWidget(
                          maxline: 20,
                          text: product.description!,
                          color: Colors.white),
                    ],
                  ))),
        ),
        GetBuilder<ProductInfoController>(builder: (productInfo) {
          return Positioned(
            bottom: 20,
            left: 15,
            child: GestureDetector(
              onTap: productInfo.exist
                  ? () {
                      Get.toNamed(AppRouts.cartPage);
                    }
                  : _toggleExpanded,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(40.h)),
                child: _expanded
                    ? ExpandedContainer(
                        button: CircleAvatar(
                          radius: 25,
                          child: IconButton(
                              onPressed: () {
                                print(productInfo.exist);
                                productInfo.addItem(product);
                                productInfo.exist ? () : _toggleExpanded();
                              },
                              icon: Icon(
                                color: secondaryColor10DarkTheme,
                                Iconsax.login_1,
                                size: 30,
                              )),
                        ),
                        pageId: widget.pageId,
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
          );
        }),
        Positioned(
          bottom: 20,
          right: 15,
          child: GestureDetector(
            onTap: _toggleOwnExpanded,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _ownExpanded ? 280.0.h : 50.0.h,
              width: _ownExpanded ? 190.0.w : 190.0.w,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(1.5, 1.5),
                    // shadow direction: bottom right
                  )
                ],
                color: Color.fromARGB(255, 167, 175, 76),
                borderRadius: BorderRadius.circular(40),
              ),
              child: _ownExpanded
                  ? ExpandedContainer(
                      button: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              color: secondaryColor10DarkTheme,
                              Iconsax.login_1,
                              size: 30,
                            )),
                      ),
                      pageId: widget.pageId,
                    )
                  : Center(
                      child: textWidget(
                          text: "Own it now",
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
            ),
          ),
        )
      ],
    );
  }
}

class ExpandedContainer extends StatelessWidget {
  int pageId;
  Widget button;
  ExpandedContainer({
    Key? key,
    required this.pageId,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (productInfo) {
      var product = Get.find<ProductInfoController>().productInfoList[pageId];
      double totel =
          (product.price!.toDouble() * productInfo.quantity.toDouble()) +
              (200 * productInfo.maleQuantity.toDouble()) +
              (100 * productInfo.feQuantity.toDouble());
      productInfo.getPrice(totel);
      return Container(
        height: 290.h,
        width: 180.w,
        child: ListView(
          children: [
            Card(
              color: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                    child: textWidget(
                        text: "Pair",
                        fontSize: 12,
                        color: secondaryColor60DarkTheme,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
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
                  textWidget(text: productInfo.quantity.toString()),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  textWidget(text: productInfo.maleQuantity.toString()),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.w),
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
                  textWidget(text: productInfo.feQuantity.toString()),
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [textWidget(text: "Tot : ₹ $totel "), button],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    });
  }
}
