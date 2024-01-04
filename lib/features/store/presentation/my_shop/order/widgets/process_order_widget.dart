import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProcessOrderWidget extends StatefulWidget {
  const ProcessOrderWidget(
      {super.key,
      required this.order,
      required this.product,
      required this.orderController});
  final dynamic order;
  final dynamic product;
  final OrderController orderController;

  @override
  State<ProcessOrderWidget> createState() => _ProcessOrderWidgetState();
}

class _ProcessOrderWidgetState extends State<ProcessOrderWidget> {
  DateTime? selectedDate;
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
      title: widget.order.processing == null
          ? MaterialButton(
              onPressed: () {
                // orderController.processOrder(order.id, 45 - 89);
                // order.processing = 'refresh.....';
                // _showDialog(context, order, orderController);
                _showDialog(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.check_box_outlined,
                    color: Theme.of(context).primaryColorDark,
                    size: 20,
                  ),
                  textWidget(
                      text: 'Order Packed',
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
                    text: 'Order Processed', color: Colors.green, fontSize: 15),
              ),
            ),
    );
  }

  Future<void> _showDialog(
    BuildContext context,
  ) async {
    Get.find<UserInfoController>().getBreedersList();
    var breedersList = Get.find<UserInfoController>().breedersList;
    await showDialog<void>(
      context: context,
      barrierDismissible:
          true, // Set to true if you want to dismiss the dialog by tapping outside
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Expecting Date'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SimpleButton(
                      onPress: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      label: "Pick delivery date"),
                  smallSpace,
                  if (selectedDate != null)
                    Text(
                        'Selected Date: ${dateWidget(selectedDate.toString())}'),
                ],
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
                              (user) => user.id == widget.order.userId,
                            );

                    if (breedersList != null) {
                      if (user != null && user.fcmToken != null) {
                        String token = user.fcmToken!;
                        NotificationHelper.sendPushNotification(
                            token,
                            "Your Order redy to ship and it delivered on${dateWidget(selectedDate.toString())}",
                            "Order packed");
                      } else {
                        print(
                            "its nulll not workingOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                      }
                    } else {
                      // Handle the case where breedersList is null
                    }
                    // Handle the entered details (detailsController.text)
                    widget.orderController.processOrder(
                        widget.order.id, dateWidget(selectedDate.toString()));
                    widget.order.processing = 'refresh.....';
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
