import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/drawer.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/all_products/presentation/widgets/horizontal.dart';
import 'package:betta_store/features/shop/all_products/presentation/widgets/recommended_hor.dart';
import 'package:betta_store/features/shop/all_products/presentation/widgets/top_rated.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/shop/feeds/presentation/widgets/horizontal.dart';
import 'package:betta_store/features/shop/fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/shop/items/presentation/widgets/horizontal.dart';
import 'package:betta_store/features/shop/plants/presentation/widgets/horizontal.dart';
import 'package:betta_store/features/store/presentation/breeders/widgets/breeder_list_widget.dart';
import 'package:betta_store/features/store/presentation/home/widgets/categories.dart';
import 'package:betta_store/features/store/presentation/home/widgets/new_orders.dart';
import 'package:betta_store/features/store/presentation/home/widgets/slider.dart';
import 'package:betta_store/features/store/presentation/home/widgets/top_bar.dart';
import 'package:betta_store/features/store/presentation/home/widgets/welcome_comment.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';

class ShopingHome extends StatefulWidget {
  const ShopingHome({super.key});

  @override
  State<ShopingHome> createState() => _ShopingHomeState();
}

class _ShopingHomeState extends State<ShopingHome> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
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
      drawer: const Drawer(
        child: DrawerItems(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: GetBuilder<ProductInfoController>(builder: (products) {
              return !products.isLoading
                  ? SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopBar(),
                          const WelcomeComment(),
                          const AdSliders(),
                          const CategoriesWidget(),
                          const NewOrdersWidget(),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: RecomProductHorizontalGrid(),
                          ),
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
                                      color: Theme.of(context)
                                          .indicatorColor
                                          .withOpacity(0.6),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                const BreederListWidget(),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: BettaFishHorizontalGrid(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: FishesHorizontslGrid(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: PlantsHorizontalGrid(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: ItemsHorizontalGrid(),
                          ),
                          bigSpace,
                          bigSpace,
                          bigSpace
                        ],
                      ),
                    )
                  : const CustomeLoader();
            })),
      ),
    );
  }
}
