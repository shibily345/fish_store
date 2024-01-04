// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/core/utils/theme/constants.dart';

class AddToCartButton extends StatefulWidget {
  dynamic product;

  AddToCartButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    int femaleOfPrice =
        widget.product.femalePrice == '' ? 0 : widget.product.femalePrice!;
    int maleOfPrice =
        widget.product.malePrice == '' ? 0 : widget.product.malePrice!;
    return GetBuilder<ProductInfoController>(builder: (productInfo) {
      double totel =
          (widget.product.price!.toDouble() * productInfo.quantity.toDouble()) +
              (maleOfPrice * productInfo.maleQuantity.toDouble()) +
              (femaleOfPrice * productInfo.feQuantity.toDouble());
      productInfo.getPrice(totel);
      return Positioned(
        bottom: 20,
        right: 15,
        child: Row(
          children: [
            GestureDetector(
              onTap: productInfo.exist
                  ? () {
                      Get.toNamed(AppRouts.getCartPage());
                    }
                  : _toggleExpanded,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                // height: _expanded ? 280.0.h : 50.0,
                width: _expanded ? 210.0.w : 210.0.w,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(1.5, 1.5),
                        // shadow direction: bottom right
                      )
                    ],
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(40.h)),
                child: _expanded
                    ? ListView(
                        shrinkWrap: true,
                        children: [
                          Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0.w),
                                  child: widget.product.typeId == 4 ||
                                          widget.product.typeId == 6
                                      ? textWidget(
                                          text: "Pair",
                                          fontSize: 12,
                                          color: secondaryColor60DarkTheme,
                                          fontWeight: FontWeight.w600)
                                      : textWidget(
                                          text: widget.product.video,
                                          fontSize: 12,
                                          color: secondaryColor60DarkTheme,
                                          fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  onPressed: () {
                                    productInfo.setQuantity(false);
                                  },
                                  icon: const Icon(
                                    Iconsax.minus_cirlce,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                                textWidget(
                                    text: productInfo.quantity.toString()),
                                IconButton(
                                  onPressed: () {
                                    productInfo.setQuantity(true);
                                  },
                                  icon: const Icon(
                                    Iconsax.add_circle,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          maleOfPrice == 0
                              ? Container()
                              : Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: textWidget(
                                            text: "Male",
                                            fontSize: 12,
                                            color: secondaryColor60DarkTheme,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setmaleQuantity(false);
                                        },
                                        icon: const Icon(
                                          Iconsax.minus_cirlce,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                      textWidget(
                                          text: productInfo.maleQuantity
                                              .toString()),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setmaleQuantity(true);
                                        },
                                        icon: const Icon(
                                          Iconsax.add_circle,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          femaleOfPrice == 0
                              ? Container()
                              : Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0.w),
                                        child: textWidget(
                                            text: "Female",
                                            fontSize: 12,
                                            color: secondaryColor60DarkTheme,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setfeQuantity(false);
                                        },
                                        icon: const Icon(
                                          Iconsax.minus_cirlce,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                      textWidget(
                                          text: productInfo.feQuantity
                                              .toString()),
                                      IconButton(
                                        onPressed: () {
                                          productInfo.setfeQuantity(true);
                                        },
                                        icon: const Icon(
                                          Iconsax.add_circle,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: "Tot : ₹ $totel "),
                                  CircleAvatar(
                                    radius: 25,
                                    child: IconButton(
                                        onPressed: () {
                                          print(productInfo.exist);

                                          productInfo.addItem(
                                              widget.product, totel);
                                          productInfo.exist
                                              ? ()
                                              : _toggleExpanded();
                                        },
                                        icon: const Icon(
                                          color: secondaryColor80DarkTheme,
                                          Iconsax.login_1,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: textWidget(
                            text: productInfo.exist
                                ? "Check it out "
                                : "Put in bag",
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      )),
              ),
            ),
          ],
        ),
      );
    });
  }
}
