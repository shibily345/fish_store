import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({super.key, this.order, required this.product});
  final dynamic order;
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          Get.toNamed(AppRouts.getProductDetailPage(product.id!));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(AppConstents.BASE_URL +
                      AppConstents.UPLOAD_URL +
                      product.img!),
                  fit: BoxFit.cover)),
          height: 120.h,
          width: 120.w,
          child: Container(),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160.w,
            child: textWidget(
              text: product.name!,
              maxline: 3,
              fontSize: 15,
              color: Theme.of(context).indicatorColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 120,
            child: textWidget(
              text: product.breeder!,
              maxline: 3,
              fontSize: 12,
              color: Theme.of(context).indicatorColor.withOpacity(0.4),
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            width: 120,
            child: textWidget(
              text: '₹${order.orderAmount}',
              maxline: 3,
              fontSize: 16,
              color: Theme.of(context).indicatorColor.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          bigSpace,
          Row(
            children: [
              order.quantity != null && order.quantity! > 0
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset("assets/fishesexample/pair.png"))
                  : Container(),
              order.quantity != null && order.quantity! > 0
                  ? textWidget(
                      color: Theme.of(context).indicatorColor,
                      text: " :  ${order.quantity!} ")
                  : Container(),
              order.maleQuantity != null && order.maleQuantity! > 0
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset("assets/fishesexample/male.png"))
                  : Container(),
              order.maleQuantity != null && order.maleQuantity! > 0
                  ? textWidget(
                      color: Theme.of(context).indicatorColor,
                      text: " :  ${order.maleQuantity!} ")
                  : Container(),
              order.femaleQuantity != null && order.femaleQuantity! > 0
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset("assets/fishesexample/female.png"))
                  : Container(),
              order.femaleQuantity != null && order.femaleQuantity! > 0
                  ? textWidget(
                      color: Theme.of(context).indicatorColor,
                      text: " :  ${order.femaleQuantity!} ")
                  : Container(),
            ],
          ),
        ],
      )
    ]);
  }
}
