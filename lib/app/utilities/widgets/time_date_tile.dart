import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../data/constants/app_text_style.dart';

class TimeAndDateTile extends StatelessWidget {
  final String? title;
  final String? date;
  final String? time;
  final double? width;

  const TimeAndDateTile({
    super.key,
    this.title,
    this.date,
    this.width,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: AppTextStyle.homeworkElements,
        ),
        8.verticalSpacing,
        Text(
          date ?? "",
          style: AppTextStyle.homeworkElements,
        ),
        2.verticalSpacing,
        Text(
          time ?? "",
          style: AppTextStyle.homeworkElements,
        ),
      ],
    );
  }
}