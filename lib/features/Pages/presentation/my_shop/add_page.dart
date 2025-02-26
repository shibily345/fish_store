import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ProductAddPage extends StatelessWidget {
  const ProductAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Container(
        child: kIsWeb
            ? const SizedBox()
            : BannerAdWId(
                unitIdAndroid: "ca-app-pub-1634533782017400/3914305606"),
      ),
      appBar: AppBar(
        title: textWidget(
          text: "Select Category",
          color: th.primaryColor,
          fontSize: 18,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 20,
          left: 30,
          right: 30,
        ),
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouts.getAddBettaPage(4));
            },
            child: BlurImageContainer(
                image: "assets/ui_elementsbgon/b2.png",
                width: Get.width * 0.47,
                height: 200.h,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      smallwidth,
                      const Icon(
                        Iconsax.add_circle,
                        color: Colors.white,
                        size: 26,
                      ),
                      textWidget(
                          text: "Betta Fish",
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      smallwidth,
                    ],
                  ),
                )),
          ),
          smallSpace,
          smallSpace,
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouts.getAddBettaPage(6));
            },
            child: _buildAddTile(
                "assets/ui_elementsbgon/koisfishes.jpeg", "Other Fishes", 100),
          ),
          smallSpace,
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouts.getAddOthersPage(5));
            },
            child: _buildAddTile(
                "assets/ui_elementsbgon/aquaplants.jpeg", "Aqua plants", 100),
          ),
          smallSpace,
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouts.getAddOthersPage(7));
            },
            child: _buildAddTile(
                "assets/ui_elementsbgon/tank1.jpg", "Accessories", 100),
          ),
          smallSpace,
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouts.getAddOthersPage(8));
            },
            child: _buildAddTile(
                "assets/ui_elementsbgon/feedsof.jpg", "Feeds for Fishes", 100),
          ),
          smallSpace,
        ],
      ),
    );
  }

  Widget _buildAddTile(String bg, String title, int height) {
    return BlurImageContainer(
        image: bg,
        width: Get.width * 0.4,
        height: height.h,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              smallwidth,
              const Icon(
                Iconsax.add_circle,
                color: Colors.white,
                size: 26,
              ),
              textWidget(
                  text: title,
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              smallwidth,
            ],
          ),
        ));
  }
}
