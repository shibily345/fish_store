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
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
          height: 100,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Get.find<UserInfoController>().userModel.name != null
                ? textWidget(
                    color: Theme.of(context).indicatorColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    text:
                        "What's up ${Get.find<UserInfoController>().userModel.name!}!")
                : textWidget(
                    text: "What's up bro!",
                    color: Theme.of(context).indicatorColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
            textWidget(
              text: "Get a littl'e beuty...",
              color: Theme.of(context).indicatorColor,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            )
          ])),
    );
  }
}
