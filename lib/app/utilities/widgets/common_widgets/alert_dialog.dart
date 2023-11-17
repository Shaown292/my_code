import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:get/get.dart';

class CustomPopupDialogue extends StatelessWidget {
  final String? title;
  final String subTitle;
  final String noText;
  final String yesText;
  final bool isLoading;
  final Function()? onYesTap;

  const CustomPopupDialogue({
    this.onYesTap,
    super.key,
    this.title,
    this.isLoading = false,
    required this.subTitle,
    required this.noText,
    required this.yesText,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text(noText.toUpperCase())),
        isLoading ? const CircularProgressIndicator(color: AppColors.primaryColor,) : TextButton(onPressed: onYesTap, child: Text(yesText.toUpperCase())),
      ],
    );
  }
}
