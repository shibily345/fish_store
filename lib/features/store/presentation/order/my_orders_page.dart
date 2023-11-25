import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({super.key});

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (orders) {
      var getCartHistoryList =
          Get.find<CartController>().getCartHistoryList().reversed.toList();
      List<int> timelineStartIndices = [];
      Map<String, int> cartItemsPerOrder = Map();
      for (int i = 0; i < getCartHistoryList.length; i++) {
        if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time!)) {
          cartItemsPerOrder.update(
              getCartHistoryList[i].time!, (value) => ++value);
        } else {
          cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
        }
      }
      List<int> cartOrderTimeToList() {
        return cartItemsPerOrder.entries.map((e) => e.value).toList();
      }

      List<int> itemsPerOrder = cartOrderTimeToList();
      var listCounter = 0;
      Widget timeWidget(int index) {
        var outputDate = DateTime.now().toString();
        if (index < getCartHistoryList.length) {
          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(getCartHistoryList[listCounter].time!);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat("EEE, MM/dd/yyyy hh:mm a");
          outputDate = outputFormat.format(inputDate);
        }
        if (timelineStartIndices.length <= itemsPerOrder.length) {
          timelineStartIndices
              .add(index); // Store the starting index for this timeline
        }
        return textWidget(
            text: outputDate, color: Theme.of(context).indicatorColor);
      }

      void _handleItemTap(int index) {
        int timelineIndex = timelineStartIndices.indexOf(index);
        int actualIndex = timelineIndex >= 0
            ? index - timelineStartIndices[timelineIndex]
            : index;

        // Access the correct item using the calculated actualIndex
        print(getCartHistoryList[actualIndex].id.toString());
        Get.toNamed(AppRouts.getOrderProgress(
            getCartHistoryList[index].id.toString() as int));
        // Rest of your onTap logic
      }

      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: textWidget(
                text: "My orders ",
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          body: Container(
            margin: EdgeInsets.only(left: 20.w),
            child: ListView(
              children: [
                for (int i = 0; i < itemsPerOrder.length; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            height: 40.h,
                            width: 200.w,
                            child: timeWidget(listCounter)),
                        Column(
                          children: [
                            Wrap(
                              children:
                                  List.generate(itemsPerOrder[i], (index) {
                                if (listCounter < getCartHistoryList.length) {
                                  listCounter++;
                                }
                                return Stack(
                                  children: [
                                    Container(
                                      height: 110.h,
                                      width: Get.width,
                                      color: const Color.fromARGB(
                                          0, 255, 255, 255),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRouts.getOrderProgress(
                                                      getCartHistoryList[
                                                              listCounter - 1]
                                                          .id
                                                          .toString() as int));
                                            },
                                            child: BlurContainer(
                                                child: Image.network(
                                                  AppConstents.BASE_URL +
                                                      AppConstents.UPLOAD_URL +
                                                      getCartHistoryList[
                                                              listCounter - 1]
                                                          .img!,
                                                  width: 120.w,
                                                  height: 120.h,
                                                ),
                                                width: 100.w,
                                                height: 100.h),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            height: 30.h,
                                            width: 193.w,
                                            child: textWidget(
                                              text: getCartHistoryList[
                                                      listCounter - 1]
                                                  .name!,
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        right: 190.w,
                                        top: 40.h,
                                        child: textWidget(
                                            text: getCartHistoryList[
                                                            listCounter - 1]
                                                        .breeder !=
                                                    null
                                                ? getCartHistoryList[
                                                        listCounter - 1]
                                                    .breeder!
                                                : "",
                                            color: Colors.grey)),
                                    Positioned(
                                        right: 20.w,
                                        bottom: 10.h,
                                        child: BlurContainer(
                                            radius: 10.h,
                                            // padding: EdgeInsets.all(value),
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0.w),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.h),
                                                    border: Border.all(
                                                        color: Colors.amber)),
                                                child: Center(
                                                  child: textWidget(
                                                      text: "Booked",
                                                      color: Colors.amber),
                                                ),
                                              ),
                                            ),
                                            width: 100.h,
                                            height: 40.w)),
                                    Positioned(
                                      left: 110.w,
                                      bottom: 20.h,
                                      child: Row(
                                        children: [
                                          getCartHistoryList[listCounter - 1]
                                                          .pquantity !=
                                                      null &&
                                                  getCartHistoryList[
                                                              listCounter - 1]
                                                          .pquantity! >
                                                      0
                                              ? SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image.asset(
                                                      "assets/fishesexample/pair.png"))
                                              : Container(),
                                          getCartHistoryList[listCounter - 1]
                                                          .pquantity !=
                                                      null &&
                                                  getCartHistoryList[
                                                              listCounter - 1]
                                                          .pquantity! >
                                                      0
                                              ? textWidget(
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  text:
                                                      " : ${getCartHistoryList[listCounter - 1].pquantity!} ")
                                              : Container(),
                                          getCartHistoryList[listCounter - 1]
                                                          .mquantity !=
                                                      null &&
                                                  getCartHistoryList[
                                                              listCounter - 1]
                                                          .mquantity! >
                                                      0
                                              ? SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image.asset(
                                                      "assets/fishesexample/male.png"))
                                              : Container(),
                                          getCartHistoryList[listCounter - 1]
                                                          .mquantity !=
                                                      null &&
                                                  getCartHistoryList[
                                                              listCounter - 1]
                                                          .mquantity! >
                                                      0
                                              ? textWidget(
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  text:
                                                      " : ${getCartHistoryList[listCounter - 1].mquantity!} ")
                                              : Container(),
                                          getCartHistoryList[listCounter - 1]
                                                          .fquantity !=
                                                      null &&
                                                  getCartHistoryList[
                                                              listCounter - 1]
                                                          .fquantity! >
                                                      0
                                              ? SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image.asset(
                                                      "assets/fishesexample/female.png"))
                                              : Container(),
                                          getCartHistoryList[listCounter - 1]
                                                          .fquantity !=
                                                      null &&
                                                  getCartHistoryList[
                                                              listCounter - 1]
                                                          .fquantity! >
                                                      0
                                              ? textWidget(
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  text:
                                                      " : ${getCartHistoryList[listCounter - 1].fquantity!} ")
                                              : Container(),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          ));
    });
  }
}
