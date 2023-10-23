import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';

class StudyButton extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? weight;
  final String? title;
  final Color? borderColor;
  final TextStyle? textStyle;
  const StudyButton({
    super.key,
    this.color,
    this.height,
    this.weight,
    this.title, this.borderColor, this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          width: 1,
          color: borderColor ?? Colors.transparent
        ),
        color: color ?? AppColors.appButtonColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
