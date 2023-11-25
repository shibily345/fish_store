import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        iconSize: height!.h,
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: width!.w,
          height: height!.h,
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll6:
        return EdgeInsets.all(
          6,
        );
      case IconButtonPadding.PaddingAll9:
        return EdgeInsets.all(
          9,
        );
      default:
        return EdgeInsets.all(
          18,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.OutlineWhiteA700:
        return Colors.black87;
      case IconButtonVariant.OutlineGray10001_1:
        return null;
      default:
        return Colors.grey;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineWhiteA700:
        return Border.all(
          color: Colors.white,
          width: 2.00,
        );
      case IconButtonVariant.OutlineGray10001_1:
        return Border.all(
          color: Colors.grey,
          width: 1.00,
        );
      case IconButtonVariant.FillGray10001:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.CircleBorder30:
        return BorderRadius.circular(
          30.00,
        );
      default:
        return BorderRadius.circular(
          15.00,
        );
    }
  }
}

enum IconButtonShape {
  CircleBorder30,
  RoundedBorder15,
}

enum IconButtonPadding {
  PaddingAll18,
  PaddingAll6,
  PaddingAll9,
}

enum IconButtonVariant {
  FillGray10001,
  OutlineWhiteA700,
  OutlineGray10001_1,
}
