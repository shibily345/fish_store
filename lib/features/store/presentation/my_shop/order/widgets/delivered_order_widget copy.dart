import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveredOrderWidget extends StatelessWidget {
  const DeliveredOrderWidget(
      {super.key,
      required this.order,
      required this.product,
      required this.orderController});
  final dynamic order;
  final dynamic product;
  final OrderController orderController;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: order.delivered == null
          ? MaterialButton(
              onPressed: () {
                _showDialog(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.home_work_outlined,
                    color: Theme.of(context).primaryColorDark,
                    size: 20,
                  ),
                  textWidget(
                      text: 'Order at Near you',
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 13),
                ],
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
                    text: 'Order Delivered', color: Colors.green, fontSize: 15),
              ),
            ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    Get.find<UserInfoController>().getBreedersList();
    var breedersList = Get.find<UserInfoController>().breedersList;
    TextEditingController detailsController = TextEditingController();
    await showDialog<void>(
      context: context,
      barrierDismissible:
          true, // Set to true if you want to dismiss the dialog by tapping outside
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Delivered Order'),
              content: TextField(
                controller: detailsController,
                decoration:
                    const InputDecoration(hintText: 'Enter Instruction of package '),
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
                    var user =
                        Get.find<UserInfoController>().breedersList.firstWhere(
                              (user) => user.id == order.userId,
                            );

                    if (breedersList != null) {
                      if (user != null && user.fcmToken != null) {
                        String token = user.fcmToken!;
                        NotificationHelper.sendPushNotification(
                            token,
                            "Your order succesfully arrived near you ",
                            "Order delivered");
                      } else {
                        print(
                            "its nulll not workingOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                      }
                    } else {
                      // Handle the case where breedersList is null
                    }
                    orderController.deliveredCoriour(
                      order.id,
                      detailsController.text,
                    );
                    order.delivered = 'loading.....';

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
  }
}
