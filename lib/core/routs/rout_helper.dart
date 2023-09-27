import 'package:betta_store/presentation/booking/address_page.dart';
import 'package:betta_store/presentation/auth/sign_in_page.dart';
import 'package:betta_store/presentation/auth/sign_up_page.dart';
import 'package:betta_store/presentation/home/Shop/shop_cart.dart';
import 'package:betta_store/presentation/home/home.dart';
import 'package:betta_store/presentation/home/home_screen.dart';
import 'package:betta_store/presentation/home/profile/my_shop/add/add_betta.dart';
import 'package:betta_store/presentation/home/search_page.dart';
import 'package:betta_store/presentation/product_detils/detile_screen.dart';
import 'package:betta_store/presentation/product_detils/feeds_detile_screen.dart';
import 'package:betta_store/presentation/product_detils/items_detile_screen.dart';
import 'package:betta_store/presentation/product_detils/other_fishes_detile_screen.dart';
import 'package:betta_store/presentation/product_detils/plants_detile_screen.dart';
import 'package:betta_store/splash/splash_screen.dart';

import 'package:get/get.dart';

class AppRouts {
  static const initial = '/';
  static const splash = '/splash';
  static const fishDetails = '/fish-details';
  static const otherfishDetails = '/otherfish-details';
  static const plantDetails = '/plant-details';
  static const itemsDetails = '/items-details';
  static const feedsDetails = '/feeds-details';
  static const cartPage = '/cart-page';
  static const signUpPage = '/up-page';
  static const signInPage = '/in-page';
  static const addressPage = '/address-page';
  static const addBettaPage = '/addBetta-page';
  static const searchPage = '/search-page';
  static String getinitial() => initial;
  static String getSplash() => splash;
  static String getCartPage() => cartPage;
  static String getUpPage() => signUpPage;
  static String getInPage() => signInPage;
  static String getAddressPage() => addressPage;
  static String getAddBettaPage(int pageId) => '$addBettaPage?pageId=$pageId';
  static String getfishDetails(int pageId) => '$fishDetails?pageId=$pageId';
  static String getOtherFishDetails(int pageId) =>
      '$otherfishDetails?pageId=$pageId';
  static String getPlantDetails(int pageId) => '$plantDetails?pageId=$pageId';
  static String getItemsDetails(int pageId) => '$itemsDetails?pageId=$pageId';
  static String getFeedsDetail(int pageId) => '$feedsDetails?pageId=$pageId';
  static List<GetPage> routs = [
    GetPage(
      name: initial,
      page: () => const Home(),
      // binding: ChatBinding(),
    ),
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      // binding: ChatBinding(),
    ),
    GetPage(
      name: addressPage,
      page: () => const AddressPage(),
      // binding: ChatBinding(),
    ),
    GetPage(
        name: fishDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return FishDetilsPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 50)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: otherfishDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return OtherFishDetilsPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 50)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: plantDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PlantDetailPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 150)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: itemsDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return ItemsDetailPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 150)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: feedsDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return FeedsDetailPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 150)
        // binding: ChatBinding(),
        ),
    GetPage(
      name: cartPage,
      page: () {
        return const ShopCartPage();
      },
      transition: Transition.downToUp,
      // binding: ChatBinding(),
    ),
    GetPage(
      name: searchPage,
      page: () {
        return const SerachPage();
      },
      transition: Transition.downToUp,
      // binding: ChatBinding(),
    ),
    GetPage(
      name: signUpPage,
      page: () {
        return const SignUpPage();
      },
      transition: Transition.downToUp,
      // binding: ChatBinding(),
    ),
    GetPage(
      name: signInPage,
      page: () {
        return const SignInPage();
      },
      transition: Transition.downToUp,
      // binding: ChatBinding(),
    ),
    GetPage(
        name: addBettaPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          return AddBettaPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 50)
        // binding: ChatBinding(),
        ),
  ];
}
