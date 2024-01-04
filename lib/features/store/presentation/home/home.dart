import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/drawer.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/all_products/presentation/widgets/recommended_hor.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/shop/fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/shop/items/presentation/widgets/horizontal.dart';
import 'package:betta_store/features/shop/plants/presentation/widgets/horizontal.dart';
import 'package:betta_store/features/store/presentation/breeders/widgets/breeder_list_for_home.dart';
import 'package:betta_store/features/store/presentation/home/widgets/categories.dart';
import 'package:betta_store/features/store/presentation/home/widgets/new_orders.dart';
import 'package:betta_store/features/store/presentation/home/widgets/slider.dart';
import 'package:betta_store/features/store/presentation/home/widgets/top_bar.dart';
import 'package:betta_store/features/store/presentation/home/widgets/welcome_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ShopingHome extends StatefulWidget {
  const ShopingHome({super.key});

  @override
  State<ShopingHome> createState() => _ShopingHomeState();
}

class _ShopingHomeState extends State<ShopingHome> {
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
                    const AdSliders(),
                    const CategoriesWidget(),
                    const NewOrdersWidget(),
                    const RecomProductHorizontalGrid(),
                    const BettaFishHorizontalGrid(),
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
                    const FishesHorizontslGrid(),
                    const PlantsHorizontalGrid(),
                    const ItemsHorizontalGrid(),
                    bigSpace,
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
