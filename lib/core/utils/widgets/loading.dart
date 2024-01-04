import 'dart:async';

import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomeLoader extends StatefulWidget {
  final bool isloading;
  final Color bg;
  const CustomeLoader(
      {super.key, this.isloading = false, this.bg = Colors.black});

  @override
  State<CustomeLoader> createState() => _CustomeLoaderState();
}

class _CustomeLoaderState extends State<CustomeLoader> {
  bool timeout = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(seconds: 10),
      () {
        if (mounted) {
          setState(() {
            timeout = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: timeout == false
          ? Container(
              decoration: BoxDecoration(
                color: widget.bg,
                borderRadius: BorderRadius.circular(20.h),
              ),
              height: 80.h,
              width: 80.w,
              child: Lottie.asset(
                  'assets/ui_elementsbgon/animation_lmeiawsk.json'),
            )
          : SimpleButton(
              onPress: () {
                setState(() {
                  loadResources();
                  timeout = false;
                  _timer = Timer(const Duration(seconds: 10), () {
                    if (mounted) {
                      setState(() {
                        timeout = true;
                      });
                    }
                  });
                });
              },
              label: "Retry ",
            ),
    );
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
  await Future.delayed(const Duration(seconds: 3));

  // Close the dialog after 3 seconds (if it's still open)
  Navigator.of(context).pop();
}
