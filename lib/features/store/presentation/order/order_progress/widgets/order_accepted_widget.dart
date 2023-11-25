import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderAcceptedWidget extends StatelessWidget {
  const OrderAcceptedWidget({
    super.key,
    required this.order,
    required this.product,
  });
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
      leading: Container(
        width: 5,
        color: Colors.red,
      ),
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
          textWidget(
            text: "Pay now",
            maxline: 3,
            fontSize: 15,
            color: Theme.of(context).indicatorColor,
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 40,
              child: MaterialButton(
                onPressed: () {},
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
            ),
          )
        ],
      ),
    );
  }
}
