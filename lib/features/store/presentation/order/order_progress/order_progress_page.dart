import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/cancelled_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/product_detail.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/animation.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/arrived_widget.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/cancel_contact_widget.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/item_booked_widget.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/ontheway_widget.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/order_accepted_widget.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/own_review.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/processing_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderProgressPage extends StatefulWidget {
  const OrderProgressPage({super.key, required this.pageId});
  final int pageId;

  @override
  State<OrderProgressPage> createState() => _OrderProgressPageState();
}

class _OrderProgressPageState extends State<OrderProgressPage> {
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];

  @override
  void initState() {
    Get.find<UserInfoController>().getBreedersList();
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
    var user = Get.find<UserInfoController>()
        .breedersList
        .firstWhere((p) => p.id == product.sellerId);

    return order.canceled == null
        ? Scaffold(
            appBar: AppBar(),
            body: GetBuilder<OrderController>(builder: (orderController) {
              return order.canceled == null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          // padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            const Divider(),
                            ProductDetailWidget(
                              product: product,
                              order: order,
                            ),
                            const Divider(),
                            bigSpace,
                            SizedBox(
                              width: Get.width,
                              child: Column(
                                children: [
                                  OrderTrackingAnimation(
                                    progress:
                                        getProgessCode(order.orderStatus!),
                                  ),
                                  const Divider(),
                                  ItemBookedWidget(
                                    product: product,
                                    order: order,
                                  ),
                                  const Divider(),
                                  if (order.accepted != null)
                                    OrderAcceptedWidget(
                                      user: user,
                                      product: product,
                                      order: order,
                                    )
                                  else
                                    Container(),
                                  const Divider(),
                                  if (order.processing != null)
                                    ProcessingWidget(
                                      order: order,
                                      product: product,
                                    )
                                  else
                                    Container(),
                                  const Divider(),
                                  if (order.handover != null)
                                    OntheWayWidget(
                                        order: order, product: product)
                                  else
                                    Container(),
                                  const Divider(),
                                  if (order.delivered != null)
                                    OrderArrivedWidget(
                                        order: order, product: product)
                                  else
                                    Container(),
                                ],
                              ),
                            ),
                            bigSpace,
                            const Divider(),
                            CancellOrContactWidget(
                                order: order,
                                product: product,
                                orderController: orderController),
                            const Divider(),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWidget(
                                      text: "From",
                                      maxline: 3,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .indicatorColor
                                          .withOpacity(0.4),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      child: textWidget(
                                        text: product.breeder!,
                                        maxline: 3,
                                        fontSize: 12,
                                        color: Theme.of(context).indicatorColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                            bigSpace,
                            if (order.delivered != null)
                              OwnReviweBoxWidget(
                                order: order,
                                product: product,
                              ),
                            bigSpace,
                            bigSpace,
                          ],
                        ),
                      ),
                    )
                  : Container();
            }))
        : CacelledPage(
            pageId: widget.pageId,
          );
  }

  double getProgessCode(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return 2;
      case 'processing':
        return 3;
      case 'cancelled':
        return 0;
      case 'on the way':
        return 4;
      case 'delivered':
        return 5;
      case 'pending':
        return 1;
      default:
        return 1; // Default color for unknown status
    }
  }
}
