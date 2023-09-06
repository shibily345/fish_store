import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/presentation/home/profile/my_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 0, 72, 130),
            Color.fromARGB(255, 38, 114, 149),
          ], // List of colors in the gradient
          begin: Alignment.topLeft, // Starting point of the gradient
          end: Alignment.bottomRight, // Ending point of the gradient
          stops: [0.0, 1.0], // Stops for each color in the gradient
          // You can also use `TileMode` to control how the gradient is repeated
          tileMode: TileMode
              .clamp, // This will repeat the gradient to fill the container
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              BlurContainer(
                  //   padding: EdgeInsets.all(value),
                  radius: 25.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Container(
                          // padding: EdgeInsets.all(20),
                          height: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.h),
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(() => CartHistory());
                        },
                        leading: Icon(
                          Iconsax.shopping_bag,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: textWidget(
                          text: "My Orders",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.all(20),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Iconsax.shop_add,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: textWidget(
                          text: "My Shop",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.all(20),
                      ),
                      ListTile(
                        leading: Icon(
                          Iconsax.setting,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: textWidget(
                          text: "Settings",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.all(20),
                      ),
                      ListTile(
                        leading: Icon(
                          Iconsax.logout,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: textWidget(
                          text: "Logout",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ],
                  ),
                  width: Get.width,
                  height: Get.height * 0.8),
            ],
          ),
        ),
      ),
    );
  }
}
