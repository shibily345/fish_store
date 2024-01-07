import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/helper/notification.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/store/domain/controller/address_Info_controller.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/place_order_model.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ConfirmBook extends StatelessWidget {
  const ConfirmBook({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<UserInfoController>().getBreedersList();
    return GetBuilder<CartController>(builder: (
      carts,
    ) {
      void sendNotification(carts, dynamic address) async {
        for (dynamic cartItem in carts) {
          print(
              "cart ::::::::::::::::::::::::::::::::::::: ${cartItem.breeder}");

          var user =
              await Get.find<UserInfoController>().breedersList.firstWhere(
                    (user) => user.name == cartItem.breeder,
                  );
          String token = user!.fcmToken!;

          NotificationHelper.sendPushNotification(
              token,
              "You have an order from ${address.name} for ${cartItem.name}",
              "Got an order");
          print(
              "notified for item ${cartItem.id}.......................................tttttttttttttttttttttttttttt");
          print('Processing cart item: ${cartItem.name}');
          // Perform any necessary operations on the cart item here
        }
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).splashColor,
          onPressed: () {
            Get.find<AuthController>().updateToken();
            String token = Get.find<UserInfoController>().userModel.fcmToken!;

            NotificationHelper.sendPushNotification(
                token,
                "Order placed Successfully Seller soon will accept your order",
                "Order placed");

            var address = Get.find<AddressInfoController>().getUserAddress();
            PlaceOrderBody placeOrderBody = PlaceOrderBody(
                cart: carts.getItems,
                orderAmount: carts.totelAmount,
                distance: address.pincode,
                scheduleAt: '3456',
                orderNote: ' hey you',
                address: address.address,
                latitude: address.pincode,
                longitude: address.secondoryPhone,
                contactPersonName: address.name,
                contactPersonNumber: address.phone);
            Get.find<OrderController>().placeOrder(_callBack, placeOrderBody);
            sendNotification(carts.getItems, address);
          },
          label: textWidget(
              text: "Place Order",
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        appBar: AppBar(
          title: textWidget(
              text: "Confirm Booking",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        body: Column(
          children: [
            GetBuilder<AddressInfoController>(builder: (
              address,
            ) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).splashColor),
                    width: Get.width,
                    //height: 250.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallSpace,
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: textWidget(
                              text: "Your address:  ",
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: textWidget(
                            text: address.getUserAddress().name,
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 10, right: 40),
                          child: textWidget(
                            text: address.getUserAddress().address,
                            maxline: 5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 10.h, right: 40.w),
                          child: textWidget(
                            text: "pin: ${address.getUserAddress().pincode}",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 10.h, right: 40.w),
                          child: textWidget(
                            text: "Phone: ${address.getUserAddress().phone}",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 10.h, right: 40.w),
                          child: textWidget(
                            text:
                                "Phone 2 : ${address.getUserAddress().secondoryPhone}",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        bigSpace,
                      ],
                    )),
              );
            }),
            Expanded(
                child: ListView.builder(
                    itemCount: carts.getItems.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 110.h,
                            width: Get.width,
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRouts.getProductDetailPage(
                                        carts.getItems[index].id!));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).splashColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 110.w,
                                      height: 110.w,
                                      child: CachedNetworkImage(
                                        imageUrl: AppConstents.BASE_URL +
                                            AppConstents.UPLOAD_URL +
                                            carts.getItems[index].img!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[800]!,
                                          highlightColor: Colors.grey[700]!,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                color: Colors.black),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 30,
                                  width: 193.w,
                                  child: textWidget(
                                    text: carts.getItems[index].name!,
                                    fontSize: 15,
                                    color: Theme.of(context).indicatorColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      carts.removeItem(carts.getItems[index]);
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          ),
                          Positioned(
                              left: 140.w,
                              top: 50.h,
                              child: textWidget(
                                  text: carts.getItems[index].breeder!,
                                  color: Theme.of(context)
                                      .indicatorColor
                                      .withOpacity(0.4))),
                          Positioned(
                            left: 140.w,
                            bottom: 20.h,
                            child: Row(
                              children: [
                                Container(
                                  child: textWidget(
                                      text:
                                          "₹ ${carts.getItems[index].price!}     ",
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                carts.getItems[index].pquantity != null &&
                                        carts.getItems[index].pquantity! > 0
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: Image.asset(
                                            "assets/fishesexample/pair.png"))
                                    : Container(),
                                carts.getItems[index].pquantity != null &&
                                        carts.getItems[index].pquantity! > 0
                                    ? textWidget(
                                        color: Theme.of(context).indicatorColor,
                                        text:
                                            " : ${carts.getItems[index].pquantity!} ")
                                    : Container(),
                                carts.getItems[index].mquantity != null &&
                                        carts.getItems[index].mquantity! > 0
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: Image.asset(
                                            "assets/fishesexample/male.png"))
                                    : Container(),
                                carts.getItems[index].mquantity != null &&
                                        carts.getItems[index].mquantity! > 0
                                    ? textWidget(
                                        color: Theme.of(context).indicatorColor,
                                        text:
                                            " : ${carts.getItems[index].mquantity!} ")
                                    : Container(),
                                carts.getItems[index].fquantity != null &&
                                        carts.getItems[index].fquantity! > 0
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: Image.asset(
                                            "assets/fishesexample/female.png"))
                                    : Container(),
                                carts.getItems[index].fquantity != null &&
                                        carts.getItems[index].fquantity! > 0
                                    ? textWidget(
                                        color: Theme.of(context).indicatorColor,
                                        text:
                                            " : ${carts.getItems[index].fquantity!} ")
                                    : Container(),
                              ],
                            ),
                          )
                        ],
                      );
                    }))
          ].animate(interval: 100.ms).fade().fadeIn(curve: Curves.easeInOut),
        ),
      );
    });
  }

  void _callBack(bool isSuccess, String message, String orderId) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().addToHistory();
    } else {
      showCustumeSnackBar(message);
    }
  }
}
