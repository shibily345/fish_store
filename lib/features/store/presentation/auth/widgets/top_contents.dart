import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopContents extends StatelessWidget {
  const TopContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              // color: Theme.of(context).splashColor,
              ),
          child: Center(
            child: SizedBox(
              width: 200,
              height: 150,
              child: Image.asset(
                'assets/bstore logos/labelWithTagWhite.png',
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        bigSpace,
        Padding(
          padding: EdgeInsets.only(top: 18.0.h, left: 28.w),
          child: textWidget(
              text: "Welcome Back",
              color: Theme.of(context).indicatorColor,
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(left: 28.0.w, bottom: 20.h),
          child: textWidget(
              text: "Sign In to Your Account",
              color: Theme.of(context).indicatorColor.withOpacity(0.4),
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
