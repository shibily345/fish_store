import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/auth_controller.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/loading.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/presentation/home/profile/my_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../infrastructure/controller/user_Info_Controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLogedIn();
    if (userLoggedIn) {
      Get.find<UserInfoController>().getUserInfo();
      print("UserLogged");
    }
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              bigSpace,
              bigSpace,
              GetBuilder<UserInfoController>(
                builder: (userInfo) {
                  return Get.find<AuthController>().userLogedIn()
                      ? (userInfo.isLoading
                          ? Expanded(
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0.h),
                                    child: Container(
                                      // padding: EdgeInsets.all(10.h),
                                      height: 250.h, width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                        border: Border.all(
                                            color: Colors.transparent),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            foregroundColor: Theme.of(context)
                                                .indicatorColor,
                                            radius: 40.h,
                                            child:
                                                FaIcon(FontAwesomeIcons.shop),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: textWidget(
                                              text:
                                                  "@${userInfo.userModel.name}",
                                              fontSize: 17,
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: textWidget(
                                              text:
                                                  "📞  ${userInfo.userModel.phone}",
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          textWidget(
                                            text:
                                                "✉️  ${userInfo.userModel.email}",
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  profileItem(
                                    tile: ListTile(
                                      onTap: () {
                                        //Get.to(() => CartHistory());
                                      },
                                      leading: Icon(
                                        Iconsax.shop_add,
                                        size: 30,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      title: textWidget(
                                        text: "My Shop",
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  profileItem(
                                    tile: ListTile(
                                      onTap: () {
                                        Get.to(() => CartHistory());
                                      },
                                      leading: Icon(
                                        Iconsax.shopping_cart,
                                        size: 30,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      title: textWidget(
                                        text: "My Orders",
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  profileItem(
                                    tile: ListTile(
                                      onTap: () {
                                        //Get.to(() => CartHistory());
                                      },
                                      leading: Icon(
                                        Iconsax.setting,
                                        size: 30,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      title: textWidget(
                                        text: "Settings",
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  profileItem(
                                    tile: ListTile(
                                      onTap: () {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.toNamed(AppRouts.getSplash());
                                      },
                                      leading: Icon(
                                        Iconsax.logout,
                                        size: 30,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      title: textWidget(
                                        text: "Log Out",
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  RichTextWidget(texts: [
                                    TextSpan(
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      text: 'Applay our ',
                                    ),
                                    TextSpan(
                                      text: ' Terms of Service \n',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                    TextSpan(
                                      text: '      and ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColorDark)),
                                  ])
                                ],
                              ),
                            )
                          : CustomeLoader())
                      : Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/ui_elementsbgon/login.json'),
                              smallSpace,
                              Center(
                                  child: MaterialButton(
                                height: 60,
                                minWidth: 160,
                                onPressed: () {
                                  Get.toNamed(AppRouts.signUpPage);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                color: Colors.amber,
                                child: textWidget(
                                    text: "Login",
                                    color: Colors.black,
                                    fontSize: 16),
                              )),
                            ],
                          ),
                        );
                },
              ),
            ],
          )),
    );
  }
}

class profileItem extends StatelessWidget {
  final Widget tile;

  profileItem({
    super.key,
    required this.tile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: BlurContainer(width: Get.width, height: 50.h, child: tile),
    );
  }
}
