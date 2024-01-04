import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeComment extends StatelessWidget {
  const WelcomeComment({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<UserInfoController>().getUserInfo();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: SizedBox(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textWidget(
          color: Theme.of(context).indicatorColor,
          fontSize: 25,
          fontWeight: FontWeight.w400,
          text: Get.find<UserInfoController>().isLoading
              ? "What's up ${Get.find<UserInfoController>().userModel.name!}!"
              : "What's up bro!",
        ),
        textWidget(
          text: "Get a littl'e beuty...",
          color: Theme.of(context).indicatorColor.withOpacity(0.7),
          fontSize: 16,
          fontWeight: FontWeight.w300,
        )
      ])),
    );
  }
}
