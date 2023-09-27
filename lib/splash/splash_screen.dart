import 'dart:async';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/auth_controller.dart';
import 'package:betta_store/infrastructure/controller/items_info_controller.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/feeds_info_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _loadResources() async {
    await Get.find<ProductInfoController>().getProductInfoList();
    await Get.find<PlantsInfoController>().getPlantsInfoList();
    await Get.find<OtherFishInfoController>().getOtherFishInfoList();
    await Get.find<FeedsInfoController>().getfeedsInfoList();
    await Get.find<ItemsInfoController>().getItemsInfoList();
    Get.find<CartController>();
    Get.find<CartRepository>();
  }

  @override
  void initState() {
    super.initState();

    Get.lazyPut(() => ProductInfoController(productInfoRepo: Get.find()));
    Get.lazyPut(() => PlantsInfoController(plantsInfoRepo: Get.find()));
    Get.lazyPut(() => OtherFishInfoController(otherFishInfoRepo: Get.find()));
    Get.lazyPut(() => ItemsInfoController(itemsInfoRepo: Get.find()));
    Get.lazyPut(() => FeedsInfoController(feedsInfoRepo: Get.find()));
    _loadResources();
    Timer(const Duration(seconds: 3),
        () => Get.offAllNamed(AppRouts.getinitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 380.h,
            left: 120.w,
            child: Image.asset(
              color: Theme.of(context).indicatorColor,
              "assets/bstore logos/fullLogoWhite.png",
              width: 160.w,
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 150.w,
            child: Column(
              children: [
                textWidget(
                  text: "From",
                  color: colorGrey1,
                  fontSize: ScreenUtil().setSp(16),
                ),
                Image.asset(
                  color: Theme.of(context).indicatorColor,
                  "assets/bstore logos/sflogo.png",
                  width: 120.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
