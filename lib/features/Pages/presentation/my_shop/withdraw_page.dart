import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({
    super.key,
  });

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  late Razorpay _razorpay;
  double donation =
      0.2 * double.parse(Get.find<UserInfoController>().userModel.balance!);
  double amount =
      double.parse(Get.find<UserInfoController>().userModel.balance!);

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  donation = 0.2 * amount;
    return Scaffold(
      appBar: AppBar(
        title: textWidget(
            text: "Withdraw Page",
            color: Theme.of(context).indicatorColor,
            fontSize: 17),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Theme.of(context).splashColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            textWidget(
                text:
                    'Withdraw money:   ₹  ${amount.toInt() - donation.toInt()}.0',
                color: Theme.of(context).indicatorColor,
                fontSize: 15),
            const SizedBox(
              height: 16.0,
            ),
            SimpleButton(
              onPress: () {},
              label: "Withdraw now",
            ),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            bigSpace,
            Container(
                width: Get.width,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          text: 'Availeble amount: ',
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                      textWidget(
                          text:
                              "₹  ${Get.find<UserInfoController>().userModel.balance!}",
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                    ],
                  ),
                ))),
            smallSpace,
            Container(
                width: Get.width,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          text: 'Platform donation: ',
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (donation > 10.0) {
                              donation = donation - 5.0;
                            } else {
                              Fluttertoast.showToast(msg: "Its minimum");
                            }
                          });
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                      textWidget(
                          text: "₹ ${donation.toInt()}",
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            donation = donation + 5.0;
                          });
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ))),
          ].animate(interval: 100.ms).fade().fadeIn(curve: Curves.easeInOut),
        ),
      ),
    );
  }
}
