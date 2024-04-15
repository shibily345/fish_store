import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemBookedWidget extends StatelessWidget {
  const ItemBookedWidget({
    super.key,
    this.order,
    this.product,
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
      isThreeLine: true,
      title: textWidget(
        text: "Item Booked",
        maxline: 3,
        fontSize: 12,
        color: Theme.of(context).indicatorColor,
        fontWeight: FontWeight.w300,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
            text: timeWidget(order.updatedAt),
            maxline: 3,
            fontSize: 12,
            color: Theme.of(context).indicatorColor.withOpacity(0.4),
            fontWeight: FontWeight.w300,
          ),
          textWidget(
            text: "Waiting for seller response",
            maxline: 3,
            fontSize: 12,
            color: Theme.of(context).indicatorColor.withOpacity(0.4),
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
