import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/address_Info_controller.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/presentation/booking/placed_page.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmBook extends StatelessWidget {
  const ConfirmBook({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (
      carts,
    ) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).splashColor,
          onPressed: () {
            carts.addToHistory();
          },
          label: textWidget(
              text: "Place Order",
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        appBar: AppBar(
          title: textWidget(text: "Confirm Booking"),
        ),
        body: Column(
          children: [
            GetBuilder<AddressInfoController>(builder: (
              addre,
            ) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlurContainer(
                    width: Get.width,
                    height: 250.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: textWidget(
                              text: "Your address:  ",
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: textWidget(
                            text: "Mohamed Shibily",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 10, right: 40),
                          child: textWidget(
                            text:
                                "Poozhikunnath (h),kaladi po. eastmanoor ward 2,   karppoeam kitta kerala edappal karnuur malappuram",
                            maxline: 5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 10.h, right: 40.w),
                          child: textWidget(
                            text: "pin: 678950",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 10.h, right: 40.w),
                          child: textWidget(
                            text: "Phone: 8606094557",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 10.h, right: 40.w),
                          child: textWidget(
                            text: "Phone 2 : 8798098787",
                            maxline: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
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
                                    print('taped');
                                    var productIndex =
                                        Get.find<ProductInfoController>()
                                            .productInfoList
                                            .indexOf(
                                                carts.getItems[index].product!);
                                    Get.toNamed(
                                        AppRouts.getfishDetails(productIndex));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).splashColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 110.w,
                                      height: 110.h,
                                      child: Image.network(
                                        AppConstents.BASE_URL +
                                            AppConstents.UPLOAD_URL +
                                            carts.getItems[index].img!,
                                        width: 150.w,
                                        height: 150.w,
                                      )),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
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
                                      // carts.existInCart(carts.getItems[index].id) =
                                      //     false;
                                      carts.deletetCart(carts.getItems[index]);
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          ),
                          Positioned(
                              left: 140.w,
                              top: 50.h,
                              child: textWidget(
                                  text: "@Gk_bettas", color: Colors.grey)),
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
          ],
        ),
      );
    });
  }
}
