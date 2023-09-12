import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomeLoader extends StatelessWidget {
  const CustomeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20.h)),
      height: 80.h,
      width: 80.w,
      child: Lottie.asset('assets/ui_elementsbgon/animation_lmeiawsk.json'),
    ));
  }
}
