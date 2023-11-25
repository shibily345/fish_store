// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlurContainer extends StatelessWidget {
  BlurContainer({
    this.radius = 15,
    this.color = const Color.fromARGB(255, 169, 169, 169),
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

class AmbiendContainer extends StatelessWidget {
  AmbiendContainer({
    this.radius = 15,
    this.color = const Color.fromARGB(255, 169, 169, 169),
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
              color: color,
              child: child,
            ),
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
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

class ContainerPage extends StatelessWidget {
  final Widget widget;

  ContainerPage({
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: widget);
  }
}

class BrickGridViewDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  final double offset;

  const BrickGridViewDelegate({
    required int crossAxisCount,
    required double offset,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    required SliverConstraints mySliverConstraints,
  })  : this.offset = offset,
        super(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio);

  @override
  SliverConstraints mySliverConstraints(SliverConstraints constraints) {
    return SliverConstraints(
      axisDirection: constraints.axisDirection,
      growthDirection: constraints.growthDirection,
      userScrollDirection: constraints.userScrollDirection,
      scrollOffset: constraints.scrollOffset,
      precedingScrollExtent: constraints.precedingScrollExtent,
      overlap: constraints.overlap,
      remainingPaintExtent: constraints.remainingPaintExtent,
      crossAxisExtent: constraints.crossAxisExtent,
      crossAxisDirection: constraints.crossAxisDirection,
      viewportMainAxisExtent: constraints.viewportMainAxisExtent,
      remainingCacheExtent: constraints.remainingCacheExtent,
      cacheOrigin: constraints.cacheOrigin,
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegateWithFixedCrossAxisCount oldDelegate) {
    return offset != oldDelegate.mainAxisSpacing;
  }
}
