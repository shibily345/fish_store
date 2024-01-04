import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustumeSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message);
}

class EmptyWidget extends StatelessWidget {
  EmptyWidget({
    super.key,
  });
  String image = 'd';
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/ui_elementsbgon/emptycart.png'))),
    ));
  }
}

Widget emptyWid({
  String image = 'assets/emptycart.png',
  String text = 'Nothing ordered yet',
}) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 150,
        width: 150,
        child: Center(
          child: Image.asset(
            image,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ),
      textWidget(text: text, color: Colors.white.withOpacity(0.3)),
      bigSpace,
    ],
  ));
}
// class ContainerDec {
//   static  shadow = boxShadow: [
//                             BoxShadow(
//                                 color = Theme.of(context)
//                                     .primaryColorDark
//                                     .withOpacity(0.3),
//                                 spreadRadius = 2.0,
//                                 blurRadius = 4,
//                                 offset = const Offset(3.0, 3.0)),
//                             BoxShadow(
//                                 color = Theme.of(context)
//                                     .primaryColorDark
//                                     .withOpacity(0.3),
//                                 spreadRadius = 2.0,
//                                 blurRadius = 4 / 2.0,
//                                 offset = const Offset(3.0, 3.0)),
//                             BoxShadow(
//                                 color = Theme.of(context)
//                                     .indicatorColor
//                                     .withOpacity(0.01),
//                                 spreadRadius = 2.0,
//                                 blurRadius = 4,
//                                 offset = const Offset(-3.0, -3.0)),
//                             BoxShadow(
//                                 color = Theme.of(context)
//                                     .indicatorColor
//                                     .withOpacity(0.01),
//                                 spreadRadius = 2.0,
//                                 blurRadius = 4 / 2,
//                                 offset = const Offset(-3.0, -3.0)),
//                           ],;
// }
