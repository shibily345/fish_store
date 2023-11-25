import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/shop/betta_fishes/data/repositories/product_info_repo.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';

import 'package:betta_store/features/store/domain/controller/address_Info_controller.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/review_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:betta_store/features/store/domain/data/repository/address_repo.dart';
import 'package:betta_store/features/store/domain/data/repository/auth_repo.dart';
import 'package:betta_store/features/store/domain/data/repository/cart_repo.dart';
import 'package:betta_store/features/shop/feeds/data/repositories/feeds_info_repo.dart';
import 'package:betta_store/features/shop/items/data/repositories/items_info_repo.dart';
import 'package:betta_store/features/shop/fishes/data/repositories/other_fish_info_repo%20copy%202.dart';
import 'package:betta_store/features/shop/plants/data/repositories/plants_info_repo.dart';
import 'package:betta_store/features/store/domain/data/repository/order_repo.dart';
import 'package:betta_store/features/store/domain/data/repository/review_repo.dart';
import 'package:betta_store/features/store/domain/data/repository/user_repo.dart';
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
  Get.lazyPut(() => PlantsInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => OtherFishInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => ItemsInfoRepo(apiClint: Get.find()));
  Get.lazyPut(() => FeedsInfoRepo(apiClint: Get.find()));
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
  Get.lazyPut(() => UserInfoController(userRepo: Get.find()));
  Get.lazyPut(() => ProductInfoController(productInfoRepo: Get.find()));
  Get.lazyPut(() => PlantsInfoController(plantsInfoRepo: Get.find()));
  Get.lazyPut(() => OtherFishInfoController(otherFishInfoRepo: Get.find()));
  Get.lazyPut(() => ItemsInfoController(itemsInfoRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => FeedsInfoController(feedsInfoRepo: Get.find()));
  Get.lazyPut(() => AddressInfoController(addressRepo: Get.find()));
  Get.lazyPut(() => ReviewController(reviewRepo: Get.find()));
}

Future<void> loadResources() async {
  await Get.find<ProductInfoController>().getProductInfoList();
  await Get.find<PlantsInfoController>().getPlantsInfoList();
  await Get.find<OtherFishInfoController>().getOtherFishInfoList();
  await Get.find<ItemsInfoController>().getItemsInfoList();
  await Get.find<FeedsInfoController>().getfeedsInfoList();
  await Get.find<OrderController>().getOrderList();
  await Get.find<OrderController>().getOrderListForSeller();
  await Get.find<ReviewController>().getReview();
}
