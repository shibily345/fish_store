import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProcessingWidget extends StatelessWidget {
  const ProcessingWidget({
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

  String dateWidget(String time) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate = DateTime.parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("EEE, MMM-dd-yyyy");
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 15.h),
      title: textWidget(
        text: "Item Packed",
        maxline: 3,
        fontSize: 12,
        color: Theme.of(context).indicatorColor,
        fontWeight: FontWeight.w300,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
            text: timeWidget(order.processing!.toString()),
            maxline: 3,
            fontSize: 10,
            color: Theme.of(context).indicatorColor.withOpacity(0.4),
            fontWeight: FontWeight.w300,
          ),
          Container(
            height: 10,
          ),
          textWidget(
            text: 'Delivery expected by ' + order.scheduled!,
            maxline: 3,
            fontSize: 13,
            color: Theme.of(context).indicatorColor.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
