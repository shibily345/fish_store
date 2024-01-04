import 'package:betta_store/features/store/presentation/booking/address_page.dart';
import 'package:betta_store/features/store/presentation/auth/sign_in_page.dart';
import 'package:betta_store/features/store/presentation/auth/sign_up_page.dart';
import 'package:betta_store/features/store/presentation/breeders/details_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/add_fish.dart';
import 'package:betta_store/features/store/presentation/cart/shop_cart.dart';
import 'package:betta_store/features/store/presentation/home/search_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/add/add_others.dart';
import 'package:betta_store/features/store/presentation/my_shop/details/edit_product.dart';
import 'package:betta_store/features/store/presentation/my_shop/details/my_product_details.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/order_detail.dart';
import 'package:betta_store/features/store/presentation/product_detils/detile_screen.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/order_progress_page.dart';
import 'package:betta_store/features/store/presentation/splash/splash_screen.dart';
import 'package:betta_store/features/skeleton/skeleton.dart';

import 'package:get/get.dart';

class AppRouts {
  static const initial = '/';
  static const splash = '/splash';
  static const fishDetails = '/fish-details';

  static const cartPage = '/cart-page';
  static const signUpPage = '/up-page';
  static const signInPage = '/in-page';
  static const addressPage = '/address-page';
  static const addBettaPage = '/addBetta-page';
  static const addOthersPage = '/addOthers-page';
  static const searchPage = '/search-page';
  static const breederDetailPage = '/breederDetail-page';
  static const orderProgressPage = '/orderProgress-page';
  static const shopsOrderProgressPage = '/orderProgress-page';
  static const myProductEdit = '/myproductedit-page';
  static const editProductPage = '/editProductPage-page';
  static String getinitial() => initial;
  static String getSplash() => splash;
  static String getCartPage() => cartPage;
  static String getUpPage() => signUpPage;
  static String getInPage() => signInPage;
  static String getAddressPage() => addressPage;
  static String getAddBettaPage(int pageId) => '$addBettaPage?pageId=$pageId';
  static String getAddOthersPage(int pageId) => '$addOthersPage?pageId=$pageId';
  static String getProductDetailPage(int pageId) =>
      '$fishDetails?pageId=$pageId';

  static String getBreederDetails(int pageId) =>
      '$breederDetailPage?pageId=$pageId';

  static String getOrderProgress(int pageId) =>
      '$orderProgressPage?pageId=$pageId';
  static String getShopsOrderProgress(int pageId) =>
      '$shopsOrderProgressPage?pageId=$pageId';
  static String getMyproductEditPage(int pageId) =>
      '$myProductEdit?pageId=$pageId';
  static String getEditProductPagePage(int pageId) =>
      '$editProductPage?pageId=$pageId';
  static List<GetPage> routs = [
    GetPage(
      name: initial,
      page: () => const Skeleton(),
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
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: orderProgressPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          return OrderProgressPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: shopsOrderProgressPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          return ShopsOrderPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)
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
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: addOthersPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          return AddOtherPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: myProductEdit,
        page: () {
          var pageId = Get.parameters['pageId'];
          return EditProductPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: editProductPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          return EditMainProductPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
    GetPage(
        name: breederDetailPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          return BreederDetailsPage(pageId: int.parse(pageId!));
        },
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)
        // binding: ChatBinding(),
        ),
  ];
}
