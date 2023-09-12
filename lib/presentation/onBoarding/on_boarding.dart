import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/utils/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: Get.width,
                    height: 700.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/ui_elementsbgon/1.png')),
                      borderRadius: BorderRadius.circular(30),
                      color: primaryColor,
                    )),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    maxRadius: 30.w,
                    backgroundColor: primaryColor,
                    child: Icon(Iconsax.arrow_right),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            textWidget(text: "Terms and Contitions apply")
          ],
        ),
      ),
    );
  }
}
