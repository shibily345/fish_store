import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';

import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/order_from.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/product_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CacelledPage extends StatefulWidget {
  const CacelledPage({super.key, required this.pageId});
  final int pageId;

  @override
  State<CacelledPage> createState() => _CacelledPageState();
}

class _CacelledPageState extends State<CacelledPage> {
  var allProducts = Get.find<ProductInfoController>().productInfoList;

  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);

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
            const Divider(),
            ProductDetailWidget(
              product: product,
              order: order,
            ),
            const Divider(),
            OrderFromWidget(order: order, product: product),
            const Divider(),
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
                text: 'Case : ${order.orderNote!}',
                color: Colors.red,
                fontSize: 13),
          ],
        );
      }),
    );
  }
}
