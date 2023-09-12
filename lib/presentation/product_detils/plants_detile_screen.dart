// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
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
import 'package:betta_store/presentation/product_detils/detile_slides.dart';
import 'package:betta_store/utils/theme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/controller/product_info_controller.dart';

class PlantDetailPage extends StatefulWidget {
  int pageId;
  PlantDetailPage({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
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
        Get.find<PlantsInfoController>().plantsInfoList[widget.pageId];
    Get.find<PlantsInfoController>().initNew(
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
                    expandedHeight: 465.h,
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
                          background: Padding(
                        padding:
                            EdgeInsets.only(top: 28.h, left: 18.w, right: 18.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            Container(
                              height: 300.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(30.h),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstents.BASE_URL +
                                            AppConstents.UPLOAD_URL +
                                            product.img!,
                                      ),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ));
                    }),
                    bottom: PreferredSize(
                      preferredSize: Size(100.w, 180.h),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 35.0.w, bottom: 15.h),
                            child: textWidget(
                                maxline: 2,
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
                    padding: EdgeInsets.zero,
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlurContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichTextWidget(texts: [
                                TextSpan(text: 'Price : \n       \n'),
                                TextSpan(
                                    text: '₹ ${product.price!}.0',
                                    style: TextStyle(fontSize: 20)),
                              ]),
                              textWidget(
                                  maxline: 3,
                                  text:
                                      ' @devine_Bettas  \n  \ndelivery in 2-7 days',
                                  color: Colors.white),
                            ],
                          ),
                          width: Get.width.w,
                          height: 100.h),
                      SizedBox(
                        height: 20.w,
                      ),
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
        GetBuilder<PlantsInfoController>(builder: (productInfo) {
          double totel =
              (product.price!.toDouble() * productInfo.quantity.toDouble());
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
                    duration: Duration(milliseconds: 300),
                    height: _expanded ? 180.0.h : 50.0,
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
                        ? Container(
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
                                            text: "item",
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
                                              icon: Icon(
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
                                SizedBox(
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
