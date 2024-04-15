import 'dart:async';

import 'package:betta_store/core/constents.dart';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/Pages/domain/data/repository/auth_repo.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/ad_list_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/auth_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/cart_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';

import 'package:betta_store/features/Pages/domain/data/repository/cart_repo.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:betta_store/features/Pages/presentation/onBoarding/on_boarding.dart';

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
      Get.lazyPut(() => OrderController(orderRepo: Get.find()));
      loadResources();
      Get.find<AuthController>().updateToken();
      Timer(const Duration(seconds: 3),
          () => Get.offAllNamed(AppRouts.getinitial()));
    } else {
      Get.lazyPut(
          () => AuthRepo(apiClint: Get.find(), sharedPreferences: Get.find()));
      // Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find()));
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Timer(const Duration(seconds: 3),
          () => Get.offAll(const OnboardingScreen()));
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
            child: Center(
              child: Image.asset(
                color: Theme.of(context).indicatorColor,
                "assets/bstore logos/fullLogoWhite.png",
                width: 160,
              ),
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
                  "assets/bstore logos/C-logo.png",
                  width: 120.w,
                ),
              ],
            ).animate().fade().fadeIn(curve: Curves.easeInOut),
          )
        ],
      ),
    );
  }
}
