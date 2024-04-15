import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/controller/order_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CancellOrContactWidget extends StatelessWidget {
  const CancellOrContactWidget({
    super.key,
    required this.order,
    required this.product,
    required this.orderController,
  });
  final dynamic order;
  final dynamic product;
  final OrderController orderController;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (order.paymentStatus == 'pending')
          MaterialButton(
            onPressed: () {
              Get.find<UserInfoController>().getBreedersList();
              var breedersList = Get.find<UserInfoController>().breedersList;
              TextEditingController detailsController = TextEditingController();
              showDialog<void>(
                context: context,
                barrierDismissible:
                    true, // Set to true if you want to dismiss the dialog by tapping outside
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return AlertDialog(
                        title: const Text('Cancell Order'),
                        content: TextField(
                          controller: detailsController,
                          decoration: const InputDecoration(
                              hintText: 'Enter Your Cancell reson'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Save'),
                            onPressed: () {
                              var user = Get.find<UserInfoController>()
                                  .breedersList
                                  .firstWhere(
                                    (user) => user.name == order.sellerId,
                                  );

                              if (breedersList != null) {
                                if (user != null && user.fcmToken != null) {
                                  String token = user.fcmToken!;
                                  NotificationHelper.sendPushNotification(
                                      token,
                                      "Your Order Cancelled by User for ${detailsController.text}",
                                      "Order cancelled");
                                } else {
                                  print(
                                      "its nulll not workingOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                                }
                              } else {
                                // Handle the case where breedersList is null
                              }
                              orderController.calncellCoriour(
                                  order.id, detailsController.text);
                              order.canceled = 'refresh.....';

                              Navigator.of(context).pop();
                              showSuccessDialog(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Theme.of(context).splashColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 20,
                ),
                smallwidth,
                textWidget(
                    text: 'Cancell Order', color: Colors.red, fontSize: 13),
              ],
            ),
          )
        else
          const SizedBox(),
        // MaterialButton(
        //   onPressed: () {},
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //   color: Theme.of(context).splashColor,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Icon(
        //         IconlyBroken.call,
        //         color: Theme.of(context).primaryColor,
        //         size: 20,
        //       ),
        //       smallwidth,
        //       textWidget(
        //           text: 'Contact seller',
        //           color: Theme.of(context).primaryColor,
        //           fontSize: 13),
        //       smallwidth,
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
