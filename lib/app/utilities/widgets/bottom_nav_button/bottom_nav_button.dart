import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';

class BottomNavButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final String text;
  final TextStyle? textStyle;
  final Function()? onTap;
  final EdgeInsets? padding;

  const BottomNavButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    required this.text,
    this.textStyle,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height ?? 40,
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
      ),
    );
  }
}
