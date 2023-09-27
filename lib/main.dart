import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/feeds_info_controller.dart';
import 'package:betta_store/infrastructure/controller/items_info_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/core/dependencies.dart' as dep;
import 'package:betta_store/utils/theme/light_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/theme/dark_theme.dart';

void main() async {
  dep.init();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(prefs);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(() => CartController(cartRepo: Get.find<CartRepository>()));
    Get.find<CartController>().getCartData();
    return ScreenUtilInit(
        designSize: const Size(411.4, 843.4),
        builder: (_, child) {
          return GetBuilder<ProductInfoController>(builder: (_) {
            return GetBuilder<PlantsInfoController>(builder: (_) {
              return GetBuilder<OtherFishInfoController>(builder: (_) {
                return GetBuilder<ItemsInfoController>(builder: (_) {
                  return GetBuilder<FeedsInfoController>(builder: (_) {
                    return GetMaterialApp(
                      themeMode: ThemeMode.system,
                      debugShowCheckedModeBanner: false,
                      title: 'Flutter Demo',
                      theme: lightTheme(context),
                      darkTheme: darkTheme(context),
                      // home: OnBoarding(),
                      initialRoute: AppRouts.getSplash(),
                      getPages: AppRouts.routs,
                    );
                  });
                });
              });
            });
          });
        });
  }
}
