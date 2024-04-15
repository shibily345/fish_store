import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/shimmer_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    Get.find<OrderController>().getOrderList();
    super.initState();
  }

  String timeWidget(String time) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate = DateTime.parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("EEE, MMM dd yyyy hh:mm a");
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: textWidget(
              text: "Your Orders",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        body: GetBuilder<OrderController>(builder: (
          orders,
        ) {
          final order = orders.currentOrderList.reversed.toList();
          print(orders.currentOrderList.length);
          if (orders.isLoading == false) {
            return order.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: order.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            height: 110.h,
                            width: Get.width,
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    debugPrint(
                                        '${order[index].id}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                                    Get.toNamed(AppRouts.getOrderProgress(
                                        order[index].id));
                                  },
                                  child: BlurContainer(
                                      width: 100.w,
                                      height: 100.h,
                                      child: CachedNetworkImage(
                                        // height: 115.h,
                                        // width: 160.w,
                                        imageUrl: AppConstents.BASE_URL +
                                            AppConstents.UPLOAD_URL +
                                            order[index].img!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: CustomeLoader(
                                          bg: Colors.transparent,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 30.h,
                                  width: 193.w,
                                  child: textWidget(
                                    text: timeWidget(order[index].pending!),
                                    fontSize: 15,
                                    color: Theme.of(context).indicatorColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              left: 120.w,
                              top: 40.h,
                              child: textWidget(
                                  text: "₹ ${order[index].orderAmount}",
                                  color: Colors.grey)),
                          Positioned(
                              left: 120.w,
                              top: 60.h,
                              child: textWidget(
                                  text: "Order Id:  #${order[index].id}",
                                  color: Colors.grey)),
                          Positioned(
                              left: 120.w,
                              top: 80.h,
                              child: textWidget(
                                  text: "From ${order[index].sellerId}",
                                  color: Colors.grey)),
                          Positioned(
                              right: 20.w,
                              bottom: 10.h,
                              child: BlurContainer(
                                width: 100.h,
                                height: 40.w,
                                radius: 10.h,
                                // padding: EdgeInsets.all(value),
                                child: Padding(
                                  padding: EdgeInsets.all(3.0.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        border: Border.all(
                                            color: getStatusColor(
                                                order[index].orderStatus!))),
                                    child: Center(
                                      child: textWidget(
                                          text: order[index].orderStatus!,
                                          color: getStatusColor(
                                              order[index].orderStatus!)),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      );
                    },
                  ).animate().fade().slideX(curve: Curves.easeInOut)
                : emptyWid();
          } else {
            return const LoadingShimPage();
          }
        }));
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return const Color.fromARGB(255, 140, 237, 143);
      case 'processing':
        return const Color.fromARGB(255, 218, 210, 135);
      case 'cancelled':
        return Colors.red;
      case 'on the way':
        return Colors.white;
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.amber;
      default:
        return Colors.black; // Default color for unknown status
    }
  }
}
