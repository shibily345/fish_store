import 'package:betta_store/features/shop/all_products/presentation/widgets/vertical.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/shop/feeds/presentation/widgets/vertical_grid.dart';
import 'package:betta_store/features/shop/fishes/presentation/widgets/widgets.dart';
import 'package:betta_store/features/shop/items/presentation/widgets/vertical.dart';
import 'package:betta_store/features/shop/plants/presentation/widgets/vertical.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key, required this.tabcontroller});
  final TabController tabcontroller;
  @override
  State<StoreView> createState() => _StoreViewState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _StoreViewState extends State<StoreView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      return productInfo.isLoaded
          ? DefaultTabController(
              length: 5,
              child:
                  TabBarView(controller: widget.tabcontroller, children: const [
                BettaFishHorizontalGrid(),
                FishesGrid(),
                PlantsGrid(),
                ItemsGrid(),
                FeedsGrid(),
                AllProductGrid()
              ]),
            )
          : const Center(
              child: CustomeLoader(),
            );
    });
  }
}
