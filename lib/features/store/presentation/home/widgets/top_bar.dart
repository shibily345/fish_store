import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/home/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';

class TopBar extends StatelessWidget {
  TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              color: Theme.of(context).primaryColor,
              'assets/bstore logos/labelWhite.png',
              width: 150.w,
              height: 80.h,
            ),
            smallwidth,
            smallwidth,
            GestureDetector(
              onTap: () {
                Get.to(() => SerachPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).splashColor),
                width: 80,
                height: 50.h,
                child: Center(
                  child: Icon(IconlyBroken.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
