import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/Pages/presentation/my_shop/order/pending_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewOrdersWidget extends StatefulWidget {
  const NewOrdersWidget({super.key});

  @override
  State<NewOrdersWidget> createState() => _NewOrdersWidgetState();
}

class _NewOrdersWidgetState extends State<NewOrdersWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<EdgeInsets> _animation;
  @override
  void initState() {
    super.initState();

    Get.find<OrderController>().getOrderListForSeller();
    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the animation using Tween
    _animation = EdgeInsetsTween(
      begin: EdgeInsets.zero,
      end: const EdgeInsets.only(right: 200.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // Repeat the animation
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getOrderListForSeller();
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
              padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 10),
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
      // : Padding(
      //     padding:
      //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      //     child: Shimmer.fromColors(
      //       baseColor: Colors.grey[800]!,
      //       highlightColor: Colors.grey[700]!,
      //       child: Container(
      //         height: 100,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(18.0),
      //             color: Colors.black),
      //       ),
      //     ),
      //   );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
