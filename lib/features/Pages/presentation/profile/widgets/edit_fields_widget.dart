import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileFielsWidgets extends StatefulWidget {
  EditProfileFielsWidgets(
      {super.key,
      //  required this.nameController,
      required this.phoneController,
      required this.locationController,
      required this.emailController,
      this.user});
  //final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController locationController;
  final TextEditingController emailController;
  dynamic user;
  @override
  State<EditProfileFielsWidgets> createState() =>
      _EditProfileFielsWidgetsState();
}

class _EditProfileFielsWidgetsState extends State<EditProfileFielsWidgets> {
  final FocusNode phoneFocus = FocusNode();
  final FocusNode locationFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  @override
  void dispose() {
    phoneFocus.dispose();
    locationFocus.dispose();
    emailFocus.dispose();
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
          // SizedBox(
          //   width: Get.width,
          //   height: 70.h,
          //   child: TextFormField(
          //     focusNode: emailFocus,
          //     textInputAction: TextInputAction.next,
          //     onEditingComplete: () {
          //       FocusScope.of(context).requestFocus(locationFocus);
          //     },
          //     keyboardType: TextInputType.multiline,
          //     maxLines: null,
          //     expands: true,
          //     style: TextStyle(color: Theme.of(context).indicatorColor),
          //     controller: widget.phoneController,
          //     decoration: InputDecoration(
          //         hintStyle:
          //             TextStyle(color: Theme.of(context).primaryColorLight),
          //         hintText: ' Phone',
          //         // prefixIcon: Icon(
          //         //   Icons.home,
          //         //   color: Colors.grey,
          //         // ),
          //         contentPadding:
          //             const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          //         border: InputBorder.none),
          //   ),
          // ),
          // Divider(
          //   thickness: 4,
          //   color: Theme.of(context).scaffoldBackgroundColor,
          // ),
          SizedBox(
            width: Get.width,
            height: 70.h,
            child: TextFormField(
              focusNode: locationFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(emailFocus);
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              style: TextStyle(color: Theme.of(context).indicatorColor),
              controller: widget.locationController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: ' Location',
                  // prefixIcon: Icon(
                  //   Icons.home,
                  //   color: Colors.grey,
                  // ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  border: InputBorder.none),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          SizedBox(
            width: Get.width,
            height: 70.h,
            child: TextFormField(
              focusNode: phoneFocus,
              textInputAction: TextInputAction.next,
              // onEditingComplete: () {
              //   FocusScope.of(context).requestFocus(locationFocus);
              // },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              style: TextStyle(color: Theme.of(context).indicatorColor),
              controller: widget.emailController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: ' Email',
                  // prefixIcon: Icon(
                  //   Icons.home,
                  //   color: Colors.grey,
                  // ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
