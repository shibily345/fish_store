import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/no_data_page.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/auth_controller.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopCartPage extends StatelessWidget {
  const ShopCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartCon) {
          return cartCon.getItems.isNotEmpty
              ? SizedBox(
                  width: Get.width,
                  height: 100.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      textWidget(
                          text: "TotPrice : ₹ ${cartCon.totelAmount}",
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      InkWell(
                        onTap: () {
                          if (Get.find<AuthController>().userLogedIn()) {
                            Get.defaultDialog(
                                title: "Confirm",
                                contentPadding: const EdgeInsets.all(20),
                                content:
                                    textWidget(text: "Add your items to cart"),
                                // confirm: textWidget(text: "Go to login"),
                                onConfirm: () {
                                  Get.toNamed(AppRouts.getAddressPage());
                                },
                                onCancel: () {
                                  Get.back();
                                });
                          } else {
                            Get.defaultDialog(
                                title: "LoginFirst",
                                // confirm: textWidget(text: "Go to login"),
                                onConfirm: () {
                                  Get.toNamed(AppRouts.signUpPage);
                                });
                          }
                        },
                        child: Container(
                          width: 140.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            color: Colors.amber,
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
                    padding: EdgeInsets.only(left: 108.0.w, bottom: 20.h),
                    child: textWidget(
                      text: "Please Add Items To The Cart",
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                );
        }),
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
              ? ListView.builder(
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
                  })
              : const NoDataPage(infoText: "");
        }));
  }
}
