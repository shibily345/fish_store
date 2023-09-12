import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/controller/items_info_controller.dart';
import 'package:betta_store/infrastructure/controller/auth_controller.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/feeds_info_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/controller/user_Info_Controller.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:betta_store/infrastructure/data/repository/auth_repo.dart';
import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/infrastructure/data/repository/feeds_info_repo.dart';
import 'package:betta_store/infrastructure/data/repository/items_info_repo.dart';
import 'package:betta_store/infrastructure/data/repository/other_fish_info_repo%20copy%202.dart';
import 'package:betta_store/infrastructure/data/repository/plants_info_repo.dart';
import 'package:betta_store/infrastructure/data/repository/product_info_repo.dart';
import 'package:betta_store/infrastructure/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance;
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => ApiClint(
      appBaseUrl: AppConstents.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClint: Get.find(), sharedPreferences: Get.find()));
//repos
  Get.lazyPut(() => ProductInfoRepo(apiClint: Get.find()));

  Get.lazyPut(() => PlantsInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => OtherFishInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => ItemsInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => FeedsInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClint: Get.find()));
//controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserInfoController(userRepo: Get.find()));
  Get.lazyPut(() => ProductInfoController(productInfoRepo: Get.find()));
  Get.lazyPut(() => PlantsInfoController(plantsInfoRepo: Get.find()));
  Get.lazyPut(() => OtherFishInfoController(otherFishInfoRepo: Get.find()));
  Get.lazyPut(() => ItemsInfoController(itemsInfoRepo: Get.find()));
  Get.lazyPut(() => FeedsInfoController(feedsInfoRepo: Get.find()));
}
