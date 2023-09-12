import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/infrastructure/helper/dependencies.dart' as dep;
import 'package:betta_store/presentation/auth/sign_in_page.dart';
import 'package:betta_store/presentation/auth/sign_up_page.dart';
import 'package:betta_store/presentation/home/home.dart';
import 'package:betta_store/presentation/home/home_screen.dart';
import 'package:betta_store/presentation/onBoarding/on_boarding.dart';
import 'package:betta_store/splash/splash_screen.dart';
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
  }
}
