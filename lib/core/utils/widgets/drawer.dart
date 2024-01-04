import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/features/store/domain/controller/address_Info_controller.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/contact_about/about_us_page.dart';
import 'package:betta_store/features/store/presentation/contact_about/contact_us_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/my_shop.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/order/order_history.dart';
import 'package:betta_store/features/store/presentation/profile/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({
    super.key,
  });

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  //bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      children: [
        Get.find<AuthController>().userLogedIn()
            ? GetBuilder<UserInfoController>(builder: (userInfo) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        top: 18.h,
                      ),
                      leading: userInfo.userModel.sellproduct == 1
                          ? CachedNetworkImage(
                              height: 70.h,
                              width: 70.w,
                              imageUrl: AppConstents.BASE_URL +
                                  AppConstents.UPLOAD_URL +
                                  userInfo.userModel.logo!,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 40,
                                backgroundImage: imageProvider,
                              ),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[800]!,
                                highlightColor: Colors.grey[700]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Colors.black),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person)),
                      subtitle: textWidget(
                          text: userInfo.userModel.location!,
                          color:
                              Theme.of(context).indicatorColor.withOpacity(0.6),
                          fontSize: 13),
                      title: textWidget(
                          text: userInfo.userModel.name!,
                          color: Theme.of(context).indicatorColor,
                          fontSize: 15),
                      onTap: () {
                        Get.to(() => const ProfilePage());
                        // Handle menu item 2 press
                      },
                    ),
                    if (userInfo.userModel.sellproduct == 1)
                      ListTile(
                        onTap: () {
                          Get.to(() => const MyShop());
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 23.0),
                        title: Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/bstore logos/logowhite.png',
                                  height: 60,
                                  color: Theme.of(context).primaryColor,
                                ),
                                textWidget(
                                    text: "My Shop",
                                    color: Theme.of(context).indicatorColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                const Icon(
                                  Icons.add_circle_rounded,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Container()
                  ],
                );
              })
            : Container(),
        bigSpace,
        ListTile(
          visualDensity: VisualDensity.standard,
          contentPadding: EdgeInsets.only(top: 8.h, left: 15.w),
          onTap: () {
            Get.to(() => const MyOrders());
          },
          leading: const Icon(Iconsax.wallet),
          title: textWidget(
              text: "My Orders",
              color: Theme.of(context).indicatorColor,
              fontSize: 13),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ),
        ListTile(
          onTap: () {
            Get.toNamed(AppRouts.cartPage);
          },
          contentPadding: EdgeInsets.only(top: 8.h, left: 15.w),
          leading: const Icon(Iconsax.shopping_cart),
          title: textWidget(
              text: "My Cart",
              color: Theme.of(context).indicatorColor,
              fontSize: 13),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ),
        bigSpace,
        textWidget(
            text: "Settings",
            color: Theme.of(context).indicatorColor,
            fontWeight: FontWeight.normal,
            fontSize: 14),
        ListTile(
          contentPadding: EdgeInsets.only(top: 8.h, left: 15.w),
          onTap: () async {
            Get.defaultDialog(
                title: "Logout ",
                contentPadding: const EdgeInsets.all(10),
                content: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                          text: "Do you confirm your intention to log out?",
                          fontSize: 15,
                          maxline: 10,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).indicatorColor),
                      smallSpace,
                    ],
                  ),
                ),
                // confirm: textWidget(text: "Go to login"),

                confirm: SimpleButton(
                    onPress: () {
                      Get.find<AuthController>().clearSharedData();
                      Get.find<CartController>().clear();
                      Get.find<CartController>().clearCartHistory();

                      Get.find<AddressInfoController>().clearAddressList();
                      Get.toNamed(AppRouts.getSplash());
                    },
                    label: 'Logout'),
                cancel: SimpleButton(
                    onPress: () {
                      Get.back();
                    },
                    label: 'Cancel'));
          },
          leading: const Icon(Iconsax.logout),
          title: textWidget(
              text: "Log Out",
              color: Theme.of(context).indicatorColor,
              fontSize: 13),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ),
        bigSpace,
        textWidget(
            text: "Support",
            color: Theme.of(context).indicatorColor,
            fontWeight: FontWeight.normal,
            fontSize: 14),
        ListTile(
          onTap: () {
            Get.to(() => const ContactUsPage());
          },
          contentPadding: EdgeInsets.only(top: 8.h, left: 15.w),
          leading: const Icon(Iconsax.support),
          title: textWidget(
              text: "Contact us",
              color: Theme.of(context).indicatorColor,
              fontWeight: FontWeight.normal,
              fontSize: 12),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ),
        ListTile(
          onTap: () {
            Get.to(() => const AboutUsPage());
          },
          contentPadding: EdgeInsets.only(top: 8.h, left: 15.w),
          leading: const Icon(Icons.app_shortcut_rounded),
          title: textWidget(
              text: "About us",
              color: Theme.of(context).indicatorColor,
              fontWeight: FontWeight.normal,
              fontSize: 12),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ),
      ].animate(interval: 60.ms).fade().slideX(curve: Curves.easeInOutExpo),
    );
  }
}
