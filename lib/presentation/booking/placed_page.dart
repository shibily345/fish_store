import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/presentation/home/profile/my_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({super.key});

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bigSpace,
            bigSpace,
            bigSpace,
            Container(
                child: Lottie.asset(
              'assets/ui_elementsbgon/done.json',
              repeat: false,
            )),
            bigSpace,
            bigSpace,
            bigSpace,
            bigSpace,
            bigSpace,
            bigSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: 150,
                  onPressed: () {
                    Get.toNamed(AppRouts.getinitial());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: Theme.of(context).splashColor,
                  child: textWidget(
                      text: "Go to home",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16),
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 150,
                  onPressed: () {
                    Get.to(() => const CartHistory());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: Theme.of(context).splashColor,
                  child: textWidget(
                      text: "Track Order",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
