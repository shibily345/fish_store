import 'dart:async';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/infrastructure/helper/dependencies.dart';
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
    init();
    await Get.find<ProductInfoController>().getProductInfoList();
    Get.find<CartController>();
    Get.find<CartRepository>();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    Timer(Duration(seconds: 3), () => Get.offAllNamed(AppRouts.getinitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 380,
            left: 120,
            child: Image.asset(
              "assets/bstore logos/fullLogoWhite.png",
              width: 160.w,
            ),
          ),
          Positioned(
            bottom: 40,
            left: 150,
            child: Column(
              children: [
                textWidget(
                  text: "From",
                  color: colorGrey1,
                  fontSize: ScreenUtil().setSp(16),
                ),
                Image.asset(
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
