import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';

import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/accept_order_widget.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/cancell_button.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/cancelled_page.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/delivered_order_widget%20copy.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/order_from.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/process_order_widget.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/product_detail.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/widgets/send_order_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopsOrderPage extends StatefulWidget {
  const ShopsOrderPage({super.key, required this.pageId});
  final int pageId;

  @override
  State<ShopsOrderPage> createState() => _ShopsOrderPageState();
}

class _ShopsOrderPageState extends State<ShopsOrderPage> {
  var allProducts = Get.find<ProductInfoController>().productInfoList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var order = Get.find<OrderController>()
        .sellerOrderList
        .toList()
        .firstWhere((p) => p.id == widget.pageId);

    var product = allProducts.firstWhere((p) => p.id == order.productId);

    return order.canceled == null
        ? Scaffold(
            appBar: AppBar(),
            body: GetBuilder<OrderController>(builder: (orderController) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      AcceptOrderWidget(
                          order: order,
                          product: product,
                          orderController: orderController),
                      if (order.accepted != null)
                        ProcessOrderWidget(
                            order: order,
                            product: product,
                            orderController: orderController)
                      else
                        Container(),
                      if (order.processing != null)
                        SendOrderWidget(
                            order: order,
                            product: product,
                            orderController: orderController)
                      else
                        Container(),
                      if (order.handover != null)
                        DeliveredOrderWidget(
                            order: order,
                            product: product,
                            orderController: orderController)
                      else
                        Container(),
                      bigSpace,
                      const Divider(),
                      if (order.accepted == null)
                        CancellWidget(
                            order: order,
                            product: product,
                            orderController: orderController)
                      else
                        Container(),
                      if (order.paymentStatus == 'done')
                        Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: textWidget(
                                text: 'Payment successfully recived',
                                color: Colors.green,
                                fontSize: 15),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.maxFinite,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: textWidget(
                                  text: 'Payment pending',
                                  color: Colors.amber,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          )
        : CacelledPage(
            pageId: widget.pageId,
          );
  }
}
