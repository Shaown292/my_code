import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class WeekTabBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final TextStyle? textStyle;
  final Function()? onTap;

  const WeekTabBarItem({
    super.key,
    required this.title,
    required this.isActive,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: (Get.width - 45) / 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isActive ? AppColors.primaryColor : Colors.white),
        child: Center(
          child: Text(
            title,
            style: isActive
                ? AppTextStyle.textStyle12WhiteW500
                : AppTextStyle.blackFontSize14W400,
          ),
        ),
      ),
    );
  }
}
