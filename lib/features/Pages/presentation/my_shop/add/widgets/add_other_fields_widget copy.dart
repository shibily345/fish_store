import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddOtherFielsWidgets extends StatefulWidget {
  const AddOtherFielsWidgets({
    super.key,
    required this.nameController,
    required this.discriptionController,
    required this.pairPriceController,
    required this.dropdown,
  });
  final TextEditingController nameController;
  final TextEditingController discriptionController;
  final TextEditingController pairPriceController;
  final Widget dropdown;
  @override
  State<AddOtherFielsWidgets> createState() => _AddFielsWidgetsState();
}

class _AddFielsWidgetsState extends State<AddOtherFielsWidgets> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode discriptionFocus = FocusNode();
  final FocusNode pairPriceFocus = FocusNode();
  @override
  void dispose() {
    nameFocus.dispose();
    discriptionFocus.dispose();
    pairPriceFocus.dispose();
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
            child: SizedBox(
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
            child: SizedBox(
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
            padding: EdgeInsets.all(5.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallwidth,
                widget.dropdown,
                SizedBox(
                  width: 150.w,
                  height: 50.h,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    focusNode: pairPriceFocus,
                    textInputAction: TextInputAction.next,
                    // onEditingComplete: () {
                    //   FocusScope.of(context).requestFocus(malePriceFocus);
                    // },
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                    controller: widget.pairPriceController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                        hintText: 'Price',
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
        ],
      ),
    );
  }
}
