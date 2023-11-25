import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditFielsWidgets extends StatefulWidget {
  EditFielsWidgets(
      {super.key,
      required this.nameController,
      required this.discriptionController,
      required this.pairPriceController,
      required this.malePriceController,
      required this.femalePController,
      required this.priceForWidget,
      this.product});
  final TextEditingController nameController;
  final TextEditingController discriptionController;
  final TextEditingController pairPriceController;
  final TextEditingController malePriceController;
  final TextEditingController femalePController;
  dynamic product;
  final Widget priceForWidget;
  @override
  State<EditFielsWidgets> createState() => _EditFielsWidgetsState();
}

class _EditFielsWidgetsState extends State<EditFielsWidgets> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode discriptionFocus = FocusNode();
  final FocusNode pairPriceFocus = FocusNode();
  final FocusNode malePriceFocus = FocusNode();
  final FocusNode femalePriceFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  @override
  void dispose() {
    nameFocus.dispose();
    discriptionFocus.dispose();
    pairPriceFocus.dispose();
    malePriceFocus.dispose();
    femalePriceFocus.dispose();
    ageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0.w),
            child: Container(
              width: Get.width,
              height: 50.h,
              child: TextFormField(
                focusNode: nameFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(discriptionFocus);
                },
                style: TextStyle(color: Theme.of(context).indicatorColor),
                controller: widget.nameController,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    hintStyle:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                    hintText: 'Full Name',
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.all(5.0.w),
            child: Container(
              width: Get.width,
              height: 150.h,
              child: TextFormField(
                focusNode: discriptionFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(pairPriceFocus);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                style: TextStyle(color: Theme.of(context).indicatorColor),
                controller: widget.discriptionController,
                decoration: InputDecoration(
                    hintStyle:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                    hintText: 'Full discription',
                    // prefixIcon: Icon(
                    //   Icons.home,
                    //   color: Colors.grey,
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallwidth,
                widget.priceForWidget,
                BlurContainer(
                  width: 150.w,
                  height: 50.h,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    focusNode: pairPriceFocus,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(malePriceFocus);
                    },
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                    controller: widget.pairPriceController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                        hintText: 'Pair',
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: Theme.of(context).indicatorColor,
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          if (widget.product.typeId == 4 || widget.product.typeId == 6)
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallwidth,
                  textWidget(
                      text: "Price /Male",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  BlurContainer(
                    width: 150.w,
                    height: 50.h,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: malePriceFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(femalePriceFocus);
                      },
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: widget.malePriceController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: ' Male',
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(),
          if (widget.product.typeId == 4 || widget.product.typeId == 6)
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallwidth,
                  textWidget(
                      text: "Price /Female",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  BlurContainer(
                    width: 150.w,
                    height: 50.h,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: femalePriceFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {},
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: widget.femalePController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Female',
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
