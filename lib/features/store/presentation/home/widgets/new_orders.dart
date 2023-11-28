import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/pending_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewOrdersWidget extends StatelessWidget {
  const NewOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<UserInfoController>().getUserInfo();
    return GetBuilder<OrderController>(builder: (
      orders,
    ) {
      final order = orders.sellerOrderList.reversed
          .where((order) =>
              order.orderStatus != "Cancelled" &&
              order.orderStatus != "Delivered")
          .toList();
      return order.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const PendingOrders());
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              textWidget(
                                text: "Pending Orders",
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                              textWidget(
                                text: " ${order.length} order",
                                color: Theme.of(context)
                                    .indicatorColor
                                    .withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          : const SizedBox();
    });
  }
}
