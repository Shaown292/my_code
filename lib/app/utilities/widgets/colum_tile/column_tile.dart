import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class ColumnTile extends StatelessWidget {
  final String? title;
  final String? value;
  final double? width;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  const ColumnTile({
    super.key,
    this.title,
    this.value,
    this.width, this.titleTextStyle, this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: titleTextStyle ??  AppTextStyle.fontSize13BlackW400,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              value ?? "",
              style: valueTextStyle ?? AppTextStyle.homeworkElements,
            ),
          ),
        ],
      ),
    );
  }
}
