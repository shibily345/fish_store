import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AcceptOrderWidget extends StatelessWidget {
  const AcceptOrderWidget(
      {super.key,
      required this.order,
      required this.product,
      required this.orderController});
  final dynamic order;
  final dynamic product;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    Get.find<UserInfoController>().getBreedersList();
    return ListTile(
        leading: Container(
          width: 5,
          color: Colors.red,
        ),
        title: Center(
          child: order.accepted == null
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
                        Icons.handshake_outlined,
                        color: Theme.of(context).primaryColorDark,
                        size: 20,
                      ),
                      textWidget(
                          text: 'Accept Order',
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 15),
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
                        text: 'Order accepted',
                        color: Colors.green,
                        fontSize: 15),
                  ),
                ),
        ));
  }

  Future<void> _showDialog(BuildContext context) async {
    Get.find<UserInfoController>().getBreedersList();
    var breedersList = Get.find<UserInfoController>().breedersList;

    print(breedersList.length);
    TextEditingController detailsController = TextEditingController();
    await showDialog<void>(
      context: context,
      barrierDismissible:
          true, // Set to true if you want to dismiss the dialog by tapping outside
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Accept Order'),
              content: TextField(
                controller: detailsController,
                decoration:
                    InputDecoration(hintText: 'Enter Your Delivery Charge'),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save'),
                  onPressed: () {
                    orderController.acceptOrder(
                        order.id, detailsController.text);
                    order.accepted = 'refresh.....';
                    var user =
                        Get.find<UserInfoController>().breedersList.firstWhere(
                              (user) => user.id == order.userId,
                            );

                    if (breedersList != null) {
                      if (user != null && user.fcmToken != null) {
                        String token = user.fcmToken!;
                        NotificationHelper.sendPushNotification(
                            token,
                            "Your Order accepted by seller pay now And contineu ",
                            "Order accepted");
                      } else {
                        print(
                            "its nulll not workingOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                      }
                    } else {
                      // Handle the case where breedersList is null
                    }

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
