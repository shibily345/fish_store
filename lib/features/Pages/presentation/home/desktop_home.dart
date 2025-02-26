import 'dart:io';

import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/drawer.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:betta_store/features/Pages/presentation/ads/native_ad.dart';
import 'package:betta_store/features/products/presentation/all/widgets/recommended_horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/betta_fishes/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/Pages/presentation/breeders/widgets/breeder_list_for_home.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/categories.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/new_orders.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/slider.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/top_bar.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/welcome_comment.dart';
import 'package:betta_store/features/products/presentation/feeds/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/items/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/other_fishes/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/plants/widgets/horizontal_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconly/iconly.dart';

class DeskTopShopingHome extends StatefulWidget {
  const DeskTopShopingHome({super.key});

  @override
  State<DeskTopShopingHome> createState() => _DeskTopShopingHomeState();
}

class _DeskTopShopingHomeState extends State<DeskTopShopingHome> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    print("open Drawer");
    _scaffoldKey.currentState!.openDrawer();
  }

  Future<void> _onRefresh() async {
    print("refreshed....................");
    setState(() {
      loadResources();
    });

    await Future.delayed(const Duration(seconds: 2));

    _refreshIndicatorKey.currentState?.show(atTop: true);
    await Future.delayed(const Duration(milliseconds: 300));

    return;
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    Size size = MediaQuery.of(context).size;
    var th = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        child: DrawerItems(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: GetBuilder<ProductInfoController>(builder: (products) {
              return Row(
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const WelcomeComment(),
                          AdSliders(
                            height: 300,
                          ),
                          const CategoriesWidget(),
                          const NewOrdersWidget(),
                          // BannerAdWId(
                          //     unitIdAndroid:
                          //         "ca-app-pub-1634533782017400/7107445155"),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, top: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: textWidget(
                                      text: "Breeders :",
                                      color: th.indicatorColor.withOpacity(0.6),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                const HomeBreederListWidget(),
                              ],
                            ),
                          ),
                          // BannerAdWId(
                          //     unitIdAndroid:
                          //         "ca-app-pub-1634533782017400/3914305606"),
                          // BannerAdWId(),
                          bigSpace,
                          bigSpace
                        ].animate(interval: 200.ms).fade().slideY(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 200)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: const SingleChildScrollView(
                      child: Column(
                        children: [
                          RecommendedProductsHorizontalGrid(),
                          BettaFishHorizontalGrid(),
                          PlantsHorizontalGrid(),
                          OtherFishesHorizontalGrid(),
                          ItemsHorizontalGrid(),
                          FeedsHorizontalGrid(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }
}
