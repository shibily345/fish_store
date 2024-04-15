import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/products/data/repositories/product_info_repo.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/ad_list_controller.dart';

import 'package:betta_store/features/Pages/domain/controller/address_Info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/auth_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/cart_controller.dart';

import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/review_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/Pages/domain/data/api/api_clint.dart';
import 'package:betta_store/features/Pages/domain/data/repository/ad_list_repo.dart';
import 'package:betta_store/features/Pages/domain/data/repository/address_repo.dart';
import 'package:betta_store/features/Pages/domain/data/repository/auth_repo.dart';
import 'package:betta_store/features/Pages/domain/data/repository/cart_repo.dart';
import 'package:betta_store/features/Pages/domain/data/repository/order_repo.dart';
import 'package:betta_store/features/Pages/domain/data/repository/review_repo.dart';
import 'package:betta_store/features/Pages/domain/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  const sharedPreferences = SharedPreferences.getInstance;
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => ApiClint(
      appBaseUrl: AppConstents.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClint: Get.find(), sharedPreferences: Get.find()));
//repos
  Get.lazyPut(() => ProductInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => AdListRepo(apiClint: Get.find()));
  // Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClint: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClint: Get.find()));
  Get.lazyPut(() => ReviewRepo(apiClint: Get.find()));
  Get.lazyPut(() => AddressRepo(
        sharedPreferences: Get.find(),
        apiClint: Get.find(),
      ));
//controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => AdlistController(adListRepo: Get.find()));
  Get.lazyPut(() => UserInfoController(userRepo: Get.find()));
  Get.lazyPut(() => ProductInfoController(productInfoRepo: Get.find()));

  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => AddressInfoController(addressRepo: Get.find()));
  Get.lazyPut(() => ReviewController(reviewRepo: Get.find()));
}

Future<void> loadResources() async {
  await Future.delayed(const Duration(seconds: 2));
  init();
  await Get.find<ProductInfoController>().getProductInfoList();
  await Get.find<AdListRepo>().getAds();

  await Get.find<OrderController>().getOrderList();
  await Get.find<UserInfoController>().getBreedersList();
  await Get.find<OrderController>().getOrderListForSeller();
  await Get.find<ReviewController>().getReview();
}
