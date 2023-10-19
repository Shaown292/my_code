import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, this.value, this.color});
  final String? value;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: Get.width * 0.17,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: color ?? AppColors.homeworkStatusRedColor
      ),
      child:  Center(
        child: Text(
          value ?? "",
          style: AppTextStyle.textStyle10WhiteW400,
        ),
      ),
    );
  }
}