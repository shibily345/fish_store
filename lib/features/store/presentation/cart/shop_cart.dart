import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/no_data_page.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';

import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopCartPage extends StatelessWidget {
  const ShopCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: textWidget(
              text: "Your Bag",
              color: Theme.of(context).indicatorColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        body: GetBuilder<CartController>(builder: (
          carts,
        ) {
          return carts.getItems.isNotEmpty
              ? ListView(
                  children: [
                    SizedBox(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouts.getProductDetailPage(
                                                  carts.getItems[index].id!));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).splashColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                  const Center(
                                                      child: CustomeLoader(
                                                bg: Colors.transparent,
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
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
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            // carts.existInCart(carts.getItems[index].id) =
                                            //     false;
                                            carts.removeItem(
                                                carts.getItems[index]);
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
                                              carts.getItems[index].pquantity! >
                                                  0
                                          ? SizedBox(
                                              width: 20.w,
                                              height: 20.h,
                                              child: Image.asset(
                                                  "assets/fishesexample/pair.png"))
                                          : Container(),
                                      carts.getItems[index].pquantity != null &&
                                              carts.getItems[index].pquantity! >
                                                  0
                                          ? textWidget(
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              text:
                                                  " : ${carts.getItems[index].pquantity!} ")
                                          : Container(),
                                      carts.getItems[index].mquantity != null &&
                                              carts.getItems[index].mquantity! >
                                                  0
                                          ? SizedBox(
                                              width: 20.w,
                                              height: 20.h,
                                              child: Image.asset(
                                                  "assets/fishesexample/male.png"))
                                          : Container(),
                                      carts.getItems[index].mquantity != null &&
                                              carts.getItems[index].mquantity! >
                                                  0
                                          ? textWidget(
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              text:
                                                  " : ${carts.getItems[index].mquantity!} ")
                                          : Container(),
                                      carts.getItems[index].fquantity != null &&
                                              carts.getItems[index].fquantity! >
                                                  0
                                          ? SizedBox(
                                              width: 20.w,
                                              height: 20.h,
                                              child: Image.asset(
                                                  "assets/fishesexample/female.png"))
                                          : Container(),
                                      carts.getItems[index].fquantity != null &&
                                              carts.getItems[index].fquantity! >
                                                  0
                                          ? textWidget(
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              text:
                                                  " : ${carts.getItems[index].fquantity!} ")
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    const Divider(),
                    GetBuilder<CartController>(builder: (cartCon) {
                      return cartCon.getItems.isNotEmpty
                          ? SizedBox(
                              width: Get.width,
                              height: 100.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  textWidget(
                                      text:
                                          "TotPrice : ₹ ${cartCon.totelAmount}",
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  InkWell(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLogedIn()) {
                                        Get.defaultDialog(
                                            title: "Confirm",
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  textWidget(
                                                      text:
                                                          "buy your items worth of ₹ ${cartCon.totelAmount}",
                                                      fontSize: 15,
                                                      maxline: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .indicatorColor),
                                                  textWidget(
                                                      text:
                                                          "\nYou are required to pay only after the seller accepts your order. Once accepted, the delivery charge will be included",
                                                      fontSize: 15,
                                                      maxline: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .indicatorColor
                                                          .withOpacity(0.5)),
                                                  smallSpace,
                                                ],
                                              ),
                                            ),
                                            // confirm: textWidget(text: "Go to login"),

                                            confirm: SimpleButton(
                                                onPress: () {
                                                  Get.toNamed(AppRouts
                                                      .getAddressPage());
                                                },
                                                label: 'Confirm'),
                                            cancel: SimpleButton(
                                                onPress: () {
                                                  Get.back();
                                                },
                                                label: 'Cancel'));
                                      } else {
                                        Get.defaultDialog(
                                            title: "Login First",
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  textWidget(
                                                      text:
                                                          "Login to Buy products",
                                                      fontSize: 15,
                                                      maxline: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .indicatorColor),
                                                  smallSpace,
                                                ],
                                              ),
                                            ),
                                            // confirm: textWidget(text: "Go to login"),

                                            confirm: SimpleButton(
                                                onPress: () {
                                                  Get.toNamed(
                                                      AppRouts.getUpPage());
                                                },
                                                label: 'Login'),
                                            cancel: SimpleButton(
                                                onPress: () {
                                                  Get.back();
                                                },
                                                label: 'Cancel'));
                                      }
                                    },
                                    child: Container(
                                      width: 140.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Center(
                                        child: textWidget(
                                            text: "Check Out",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 108.0.w, bottom: 20.h),
                                child: textWidget(
                                  text: "Please Add Items To The Cart",
                                  color: Theme.of(context).indicatorColor,
                                ),
                              ),
                            );
                    }),
                    const Divider(),
                    bigSpace,
                    bigSpace,
                  ]
                      .animate(interval: 100.ms)
                      .fade()
                      .fadeIn(curve: Curves.easeInOutExpo),
                )
              : const NoDataPage(infoText: "");
        }));
  }
}
