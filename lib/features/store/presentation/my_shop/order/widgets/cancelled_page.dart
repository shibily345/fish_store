import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/accept_order_widget.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/delivered_order_widget%20copy.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/order_from.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/process_order_widget.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/product_detail.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/send_order_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CacelledPage extends StatefulWidget {
  CacelledPage({super.key, required this.pageId});
  final int pageId;

  @override
  State<CacelledPage> createState() => _CacelledPageState();
}

class _CacelledPageState extends State<CacelledPage> {
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];

  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var order = Get.find<OrderController>()
        .currentOrderList
        .toList()
        .firstWhere((p) => p.id == widget.pageId);

    var product = allProducts.firstWhere((p) => p.id == order.productId);

    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            Divider(),
            ProductDetailWidget(
              product: product,
              order: order,
            ),
            Divider(),
            OrderFromWidget(order: order, product: product),
            Divider(),
            bigSpace,
            Container(
              height: 80.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: textWidget(
                    text: 'Order Canceled', color: Colors.red, fontSize: 13),
              ),
            ),
            bigSpace,
            const Divider(),
            textWidget(
                text: 'Case : ' + order.orderNote!,
                color: Colors.red,
                fontSize: 13),
          ],
        );
      }),
    );
  }
}
