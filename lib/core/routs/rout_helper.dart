import 'package:betta_store/presentation/home/Shop/shop_cart.dart';
import 'package:betta_store/presentation/home/home.dart';
import 'package:betta_store/presentation/home/home_screen.dart';
import 'package:betta_store/presentation/product_detils.dart/detile_screen.dart';
import 'package:betta_store/splash/splash_screen.dart';

import 'package:get/get.dart';

class AppRouts {
  static const initial = '/';
  static const splash = '/splash';
  static const fishDetails = '/fish-details';
  static const cartPage = '/cart-page';
  static String getinitial() => '$initial';
  static String getSplash() => '$splash';
  static String getCartPage() => '$cartPage';
  static String getfishDetails(int pageId) => '$fishDetails?pageId=$pageId';
  static List<GetPage> routs = [
    GetPage(
      name: initial,
      page: () => Home(),
      // binding: ChatBinding(),
    ),
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      // binding: ChatBinding(),
    ),
    GetPage(
        name: fishDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return FishDetilsPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 50)
        // binding: ChatBinding(),
        ),
    GetPage(
      name: cartPage,
      page: () {
        return ShopCartPage();
      },
      transition: Transition.downToUp,
      // binding: ChatBinding(),
    ),
  ];
}
