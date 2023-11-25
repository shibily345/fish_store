import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomeLoader extends StatelessWidget {
  final bool isloading;
  final Color bg;
  const CustomeLoader(
      {super.key, this.isloading = false, this.bg = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20.h)),
      height: 80.h,
      width: 80.w,
      child: Lottie.asset('assets/ui_elementsbgon/animation_lmeiawsk.json'),
    ));
  }
}

Future<void> showSuccessDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Set your desired border radius here
        ),
        content: Container(
            child: Lottie.asset(
          'assets/ui_elementsbgon/done.json',
          repeat: false,
        )),
      );
    },
  );

  // Delay the closing of the dialog for 3 seconds
  await Future.delayed(Duration(seconds: 3));

  // Close the dialog after 3 seconds (if it's still open)
  Navigator.of(context).pop();
}
