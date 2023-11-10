import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final String? title;
  final TextStyle? textStyle;
  final Function()? onTap;

  const PrimaryButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.title,
    this.onTap,
    this.textStyle, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 30,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 6),
          color: color ?? AppColors.appButtonColor,
          border: Border.all(color: borderColor ?? Colors.transparent)
        ),
        child: Center(
          child: Text(
            title ?? "Button",
            style: textStyle ?? AppTextStyle.textStyle12WhiteW500,
          ),
        ),
      ),
    );
  }
}
