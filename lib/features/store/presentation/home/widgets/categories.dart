import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/pages/detail_page.dart';
import 'package:betta_store/features/shop/feeds/presentation/pages/detail_page.dart';
import 'package:betta_store/features/shop/fishes/presentation/pages/detail_page.dart';
import 'package:betta_store/features/shop/items/presentation/pages/detail_page.dart';
import 'package:betta_store/features/shop/plants/presentation/pages/detail_page.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<UserInfoController>().getUserInfo();
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, bottom: 0, top: 15),
      child: SizedBox(
          height: 90,
          child: ListView(
            padding: EdgeInsets.only(left: 10.w),
            scrollDirection: Axis.horizontal,
            children: [
              categoryBox(
                  context, 'assets/ui_elementsbgon/betta.png', "Betta Fishes",
                  () {
                Get.to(() => const BettaFishPage());
              }),
              categoryBox(context, 'assets/ui_elementsbgon/fish.png', "Fishes",
                  () {
                Get.to(() => const OtherFishPage());
              }),
              categoryBox(context, 'assets/ui_elementsbgon/plant.png', "Plants",
                  () {
                Get.to(() => const PlantsPage());
              }),
              categoryBox(
                  context, 'assets/ui_elementsbgon/tank.png', "Aqua Items", () {
                Get.to(() => const ItemsPage());
              }),
              categoryBox(
                  context, 'assets/ui_elementsbgon/feed.png', "Fish feeds", () {
                Get.to(() => const FeedsFishPage());
              }),
            ].animate(interval: 300.ms).fade().slideX(curve: Curves.easeInOut),
          )),
    );
  }

  Padding categoryBox(
      BuildContext context, String img, String title, VoidCallback ontap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).splashColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                img,
                width: 40.w,
                height: 40.h,
              ),
              textWidget(
                text: title,
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                fontSize: 8,
                fontWeight: FontWeight.w300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
