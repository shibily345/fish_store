import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoDataPage extends StatelessWidget {
  final String infoText;
  final String imagePath;
  const NoDataPage(
      {super.key,
      required this.infoText,
      this.imagePath = 'assets/emptycart.png'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset('assets/ui_elementsbgon/empty.json'),
          ),
          bigSpace,
        ],
      ),
    );
  }
}
