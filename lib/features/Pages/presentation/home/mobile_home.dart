import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/drawer.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:betta_store/features/Pages/presentation/ads/native_ad.dart';
import 'package:betta_store/features/Pages/presentation/breeders/widgets/breeder_list_for_home.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/categories.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/new_orders.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/slider.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/top_bar.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/welcome_comment.dart';
import 'package:betta_store/features/products/presentation/all/widgets/recommended_horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/betta_fishes/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/products/presentation/feeds/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/items/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/other_fishes/widgets/horizontal_grid.dart';
import 'package:betta_store/features/products/presentation/plants/widgets/horizontal_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MobileShopingHome extends StatefulWidget {
  const MobileShopingHome({super.key});

  @override
  State<MobileShopingHome> createState() => _MobileShopingHomeState();
}

class _MobileShopingHomeState extends State<MobileShopingHome> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

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

    return Scaffold(
      bottomNavigationBar: const SizedBox(),
      key: _scaffoldKey,
      drawer: const Drawer(
        child: DrawerItems(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: GetBuilder<ProductInfoController>(builder: (products) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      drawerWid: GestureDetector(
                        onTap: () {
                          _openDrawer();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).splashColor),
                          width: 50,
                          height: 50.h,
                          child: const Center(
                            child: Icon(Icons.menu_open),
                          ),
                        ),
                      ),
                    ),
                    const WelcomeComment(),
                    AdSliders(),
                    const CategoriesWidget(),
                    const NewOrdersWidget(),
                    const RecommendedProductsHorizontalGrid(),
                    const BettaFishHorizontalGrid(),
                    kIsWeb
                        ? const SizedBox()
                        : BannerAdWId(
                            unitIdAndroid:
                                "ca-app-pub-1634533782017400/7107445155"),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0.0, top: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: textWidget(
                                text: "Breeders :",
                                color: Theme.of(context)
                                    .indicatorColor
                                    .withOpacity(0.6),
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                          const HomeBreederListWidget(),
                        ],
                      ),
                    ),
                    const NativeAdWidget(),
                    const OtherFishesHorizontalGrid(),
                    kIsWeb
                        ? const SizedBox()
                        : BannerAdWId(
                            unitIdAndroid:
                                "ca-app-pub-1634533782017400/3914305606"),
                    const PlantsHorizontalGrid(),
                    const ItemsHorizontalGrid(),
                    const FeedsHorizontalGrid(),
                    kIsWeb ? const SizedBox() : BannerAdWId(),
                    bigSpace,
                    bigSpace
                  ].animate(interval: 200.ms).fade().slideY(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200)),
                ),
              );
            })),
      ),
    );
  }
}
