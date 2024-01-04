import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderAcceptedWidget extends StatelessWidget {
  const OrderAcceptedWidget({
    super.key,
    required this.order,
    required this.product,
    required this.user,
  });
  final UserModel user;
  final dynamic order;
  final dynamic product;
  String timeWidget(String time) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate = DateTime.parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("EEE, MMM-dd-yyyy hh:mm a");
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 15.h),
      //contentPadding: EdgeInsets.zero,

      title: textWidget(
        text: "Order accepted",
        maxline: 3,
        fontSize: 12,
        color: Theme.of(context).indicatorColor,
        fontWeight: FontWeight.w300,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
            text: timeWidget(order.accepted!.toString()),
            maxline: 3,
            fontSize: 10,
            color: Theme.of(context).indicatorColor.withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
          smallSpace,
          order.paymentStatus == 'pending'
              ? textWidget(
                  text: "Pay now",
                  maxline: 3,
                  fontSize: 15,
                  color: Theme.of(context).indicatorColor,
                  fontWeight: FontWeight.w600,
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: order.paymentStatus == 'pending'
                ? SizedBox(
                    height: 40,
                    child: MaterialButton(
                      onPressed: () {
                        Get.to(() => PaymentPage(
                            order: order, product: product, user: user));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            color: Theme.of(context).primaryColorDark,
                            size: 20,
                          ),
                          textWidget(
                              text: 'Delivery Charge: ' +
                                  order.deliveryCharge!.toString() +
                                  " + " +
                                  order.orderAmount.toString(),
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 13),
                        ],
                      ),
                    ),
                  )
                : Container(
                    width: double.maxFinite,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: textWidget(
                          text:
                              'Succesfully payed   ${order.orderAmount + order.deliveryCharge}₹',
                          color: Colors.green,
                          fontSize: 15),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
