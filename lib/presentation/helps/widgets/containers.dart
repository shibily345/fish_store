// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  BlurContainer({
    this.radius = 15,
    this.color = Colors.white,
    this.padding = EdgeInsets.zero,
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  Color color;
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
              color: color.withOpacity(0.2),
              child: child,
            ),
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          )),
    );
  }
}

class BlurImageContainer extends StatelessWidget {
  BlurImageContainer({
    this.radius = 15,
    this.color = Colors.white,
    this.padding = EdgeInsets.zero,
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    required this.image,
  }) : super(key: key);
  final String image;
  Color color;
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
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            child: Container(
              color: Colors.black.withOpacity(0.6),
              child: child,
            ),
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          )),
    );
  }
}
