import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class OntheWayWidget extends StatelessWidget {
  const OntheWayWidget({
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
        text: "Item On the way",
        maxline: 3,
        fontSize: 12,
        color: Theme.of(context).indicatorColor,
        fontWeight: FontWeight.w300,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
            text: timeWidget(order.handover),
            maxline: 3,
            fontSize: 13,
            color: Theme.of(context).indicatorColor.withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
          textWidget(
            text: "Item successfully submit to coriour services",
            maxline: 3,
            fontSize: 13,
            color: Theme.of(context).indicatorColor.withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
          GestureDetector(
            onTap: () {
              _copyToClipboard(order.trackId);
            },
            child: textWidget(
              text:
                  "Tracking Id : ${order.trackId} by ${order.deliveryCompany}",
              maxline: 3,
              fontSize: 14,
              color: Theme.of(context).indicatorColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) => Fluttertoast.showToast(
        msg: 'Id copied to clipboard: $text', toastLength: Toast.LENGTH_SHORT));
  }
}
