// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({
    this.radius = 15,
    this.padding = EdgeInsets.zero,
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);
  final EdgeInsets padding;
  final double radius;
  final Widget child;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            child: Container(
              color: Theme.of(context).indicatorColor.withOpacity(0.2),
              child: child,
            ),
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          )),
    );
  }
}
