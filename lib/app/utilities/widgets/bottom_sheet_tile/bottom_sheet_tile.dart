import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';

class BottomSheetTile extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;

  const BottomSheetTile({
    super.key,
    this.title,
    this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.homeworkWidgetColor,
        ),
        color: color,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: Get.width * 0.3,
            child: Text(
              title ?? "",
              style: AppTextStyle.fontSize12lightViolateW400,
            ),
          ),
          VerticalDivider(
            color: AppColors.bottomSheetDividerColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              value ?? "",
              style: AppTextStyle.blackFontSize12W400,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
