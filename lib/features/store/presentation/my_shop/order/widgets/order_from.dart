import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class OrderFromWidget extends StatelessWidget {
  const OrderFromWidget(
      {super.key, required this.order, required this.product});
  final dynamic order;
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
          text: "From",
          maxline: 1,
          fontSize: 12,
          color: Theme.of(context).indicatorColor.withOpacity(0.4),
          fontWeight: FontWeight.w300,
        ),
        textWidget(
          text: order.deliveryAddress!.name +
              '\n' +
              order.deliveryAddress!.address +
              '\n' +
              order.deliveryAddress!.pincode +
              '\n' +
              order.deliveryAddress!.phone +
              '\n' +
              order.deliveryAddress!.secondoryPhone,
          maxline: 33,
          fontSize: 12,
          color: Theme.of(context).indicatorColor,
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }
}
