import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class ColumnTile extends StatelessWidget {
  final String? title;
  final String? value;
  final double? width;

  const ColumnTile({
    super.key,
    this.title,
    this.value,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * 0.24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: AppTextStyle.homeworkElements,
          ),
          8.verticalSpacing,
          Text(
            value ?? "",
            style: AppTextStyle.homeworkElements,
          ),
        ],
      ),
    );
  }
}
