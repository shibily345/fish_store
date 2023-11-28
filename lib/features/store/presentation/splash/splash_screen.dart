import 'dart:async';

import 'package:betta_store/core/constents.dart';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/ad_list_controller.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';

import 'package:betta_store/features/store/domain/data/repository/cart_repo.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/onBoarding/on_boarding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _logInto();
  }

  Future<void> _logInto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstents.TOKEN)) {
      Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
      Get.lazyPut(() => CartController(cartRepo: Get.find()));
      Get.lazyPut(() => ProductInfoController(productInfoRepo: Get.find()));
      Get.lazyPut(() => AdlistController(adListRepo: Get.find()));
      Get.lazyPut(() => PlantsInfoController(plantsInfoRepo: Get.find()));
      Get.lazyPut(() => OtherFishInfoController(otherFishInfoRepo: Get.find()));
      Get.lazyPut(() => ItemsInfoController(itemsInfoRepo: Get.find()));
      Get.lazyPut(() => FeedsInfoController(feedsInfoRepo: Get.find()));
      loadResources();
      Get.find<AuthController>().updateToken();
      Timer(const Duration(seconds: 3),
          () => Get.offAllNamed(AppRouts.getinitial()));
    } else {
      // Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Timer(const Duration(seconds: 3), () => Get.offAll(OnboardingScreen()));
    }
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
                  color: Theme.of(context).indicatorColor.withOpacity(0.5),
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
