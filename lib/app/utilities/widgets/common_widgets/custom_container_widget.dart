import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomContainerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Widget requiredWidget;
  final double? borderWidth;
  final Color? borderColor;

  const CustomContainerWidget({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    required this.requiredWidget,
    this.borderWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: color ?? Colors.white,
          border: Border.all(
              color: borderColor ?? Colors.white, width: borderWidth ?? 0)),
      child: requiredWidget,
    );
  }
}
