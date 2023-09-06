import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/cart_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/data/repository/cart_repo.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
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
          return Container(
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
                    cartCon.addToHistory();
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
          );
        }),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: textWidget(
              text: "Your Bag",
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        body: GetBuilder<CartController>(builder: (
          carts,
        ) {
          return ListView.builder(
              itemCount: carts.getItems.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 110.h,
                      width: Get.width,
                      color: const Color.fromARGB(0, 255, 255, 255),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              var productIndex =
                                  Get.find<ProductInfoController>()
                                      .productInfoList
                                      .indexOf(carts.getItems[index].product!);
                              Get.toNamed(
                                  AppRouts.getfishDetails(productIndex));
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Image.network(
                                    AppConstents.BASE_URL +
                                        AppConstents.UPLOAD_URL +
                                        carts.getItems[index].img!,
                                    width: 110.w,
                                    height: 110.h,
                                  ),
                                ),
                                BlurContainer(
                                    child: Image.network(
                                      AppConstents.BASE_URL +
                                          AppConstents.UPLOAD_URL +
                                          carts.getItems[index].img!,
                                      width: 150.w,
                                      height: 150.h,
                                    ),
                                    width: 110.w,
                                    height: 110.h),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 30,
                            width: 193.w,
                            child: textWidget(
                              text: carts.getItems[index].name!,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                // carts.existInCart(carts.getItems[index].id) =
                                //     false;
                                carts.deletetCart(carts.getItems[index]);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                    Positioned(
                        left: 140.w,
                        top: 50.h,
                        child:
                            textWidget(text: "@Gk_bettas", color: Colors.grey)),
                    Positioned(
                      left: 140.w,
                      bottom: 20.h,
                      child: Row(
                        children: [
                          Container(
                            child: textWidget(
                                text: "₹ ${carts.getItems[index].price!}     ",
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
                                  color: Colors.white,
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
                                  color: Colors.white,
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
                                  color: Colors.white,
                                  text:
                                      " : ${carts.getItems[index].fquantity!} ")
                              : Container(),
                        ],
                      ),
                    )
                  ],
                );
              });
        }));
  }
}
