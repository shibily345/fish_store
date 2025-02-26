import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/Pages/presentation/home/search_page.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class TopBar extends StatelessWidget {
  TopBar({
    super.key,
    this.serchBar,
    this.tabs,
    required this.drawerWid,
  });
  final Widget drawerWid;
  Widget? serchBar;
  Widget? tabs;
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
              width: 150,
              height: 80.h,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const SerachPage());
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    serchBar ??
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).splashColor),
                          width: 80.w,
                          height: 50.h,
                          child: const Center(
                            child: Icon(IconlyBroken.search),
                          ),
                        ),
                    const SizedBox(
                      width: 20,
                    ),
                    drawerWid,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
