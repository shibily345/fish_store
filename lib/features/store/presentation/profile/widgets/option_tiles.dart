import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/address_Info_controller.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/store/presentation/contact_about/about_us_page.dart';
import 'package:betta_store/features/store/presentation/contact_about/contact_us_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/my_shop.dart';
import 'package:betta_store/features/store/presentation/order/order_history.dart';
import 'package:betta_store/features/store/presentation/profile/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OptionTilesWidget extends StatelessWidget {
  const OptionTilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).splashColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Get.to(() => const MyShop());
            },
            leading: Icon(
              Iconsax.shop_add,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: textWidget(
              text: "My Shop",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const MyOrders());
            },
            leading: Icon(
              Iconsax.shopping_cart,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: textWidget(
              text: "My Orders",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const SettingsPage());
            },
            leading: Icon(
              Iconsax.setting,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: textWidget(
              text: "Settings",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const ContactUsPage());
            },
            leading: Icon(
              Icons.contact_support_outlined,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: textWidget(
              text: "Contact us",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const AboutUsPage());
            },
            leading: Icon(
              Icons.app_shortcut,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: textWidget(
              text: "About us",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          ListTile(
            onTap: () {
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
            leading: Icon(
              Iconsax.logout,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: textWidget(
              text: "Log Out",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
