import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/infrastructure/data/repository/product_info_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance;
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => ApiClint(appBaseUrl: AppConstents.BASE_URL));
  Get.lazyPut(() => ProductInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() => ProductInfoController(productInfoRepo: Get.find()));
}
