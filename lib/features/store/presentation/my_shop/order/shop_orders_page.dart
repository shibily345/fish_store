import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/presentation/home/widgets/shimmer_loading.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/order_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ShopOrders extends StatefulWidget {
  const ShopOrders({super.key});

  @override
  State<ShopOrders> createState() => _ShopOrdersState();
}

class _ShopOrdersState extends State<ShopOrders> {
  @override
  void initState() {
    Get.find<OrderController>().getOrderListForSeller();
    super.initState();
  }

  String timeWidget(String time) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate = DateTime.parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("hh:mm a, MMM-dd-yyyy ");
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
          final order = orders.sellerOrderList.reversed.toList();
          print(orders.sellerOrderList.length);
          if (orders.isLoading == false) {
            return order.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                    Get.to(() => ShopsOrderPage(
                                        pageId: order[index].id));
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
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[800]!,
                                          highlightColor: Colors.grey[700]!,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                color: Colors.black),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: 193.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                        text: "Order Id:  #${order[index].id}",
                                        fontSize: 12,
                                        color: Theme.of(context).indicatorColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textWidget(
                                          text: "₹ ${order[index].orderAmount}",
                                          color: Colors.grey),
                                      textWidget(
                                          text:
                                              timeWidget(order[index].pending!),
                                          color: Colors.grey),
                                      textWidget(
                                          text: "From " +
                                              order[index]
                                                  .deliveryAddress!
                                                  .pincode
                                                  .toString() +
                                              ',' +
                                              order[index]
                                                  .deliveryAddress!
                                                  .address,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                  )
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
