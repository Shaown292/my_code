

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {

  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final String? title;
  final Function()? onTap;


  const PrimaryButton({super.key, this.height, this.width, this.radius, this.color, this.title, this.onTap,});

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
        ),
        child: Center(
          child: Text(
            title ?? "Button",
            style: AppTextStyle.textStyle12WhiteW500,
          ),
        ),
      ),
    );
  }
}
