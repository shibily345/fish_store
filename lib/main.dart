import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/ad_list_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/cart_controller.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart' as ad;
import 'package:betta_store/core/dependencies.dart' as dep;
import 'package:betta_store/core/utils/theme/light_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/theme/dark_theme.dart';

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification?.title}/${message.notification?.body}/"
      "${message.notification?.titleLocKey}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  dep.init();

  WidgetsFlutterBinding.ensureInitialized();
  ad.MobileAds.instance.initialize();
  Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return ScreenUtilInit(
        designSize: const Size(411.4, 843.4),
        builder: (_, child) {
          return GetBuilder<ProductInfoController>(builder: (_) {
            Get.find<AdlistController>().getAllads();
            Get.find<UserInfoController>().getUserInfo();
            Get.find<OrderController>().getOrderListForSeller();

            return GetMaterialApp(
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: lightTheme(context),
              darkTheme: darkTheme(context),
              initialRoute: AppRouts.getSplash(),
              getPages: AppRouts.routs,
            );
          });
        });
  }
}
