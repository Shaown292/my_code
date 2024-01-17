import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final String text;
  final TextStyle? textStyle;
  final Function()? onTap;
  final EdgeInsets? padding;

  const PrimaryButton({
    super.key,
     this.height,
     this.width,
    this.color,
    required this.text,
    this.onTap,
    this.borderRadius,
    this.textStyle, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? Get.height * 0.055,
        width: width,
        padding: padding,
        decoration: ShapeDecoration(
          color: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? AppTextStyle.textStyle12WhiteW500,
          ),
        ),
      ),
    );
  }
}
