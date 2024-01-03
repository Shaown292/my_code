import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class QuoteText extends StatelessWidget {
  final String? repliedText;

  const QuoteText({
    super.key,
    this.repliedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.customDividerColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Replying to :",
            style: AppTextStyle.blackFontSize12W400,
          ),
          Text(
            repliedText ?? "",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ],
      ),
    );
  }
}
