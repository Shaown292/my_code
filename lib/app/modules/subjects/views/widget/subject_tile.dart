import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';

class SubjectTile extends StatelessWidget {

  final String? subject;
  final String? teacher;
  final String? lectureType;

  const SubjectTile({
    super.key,
    this.subject,
    this.teacher,
    this.lectureType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.25,
                child:  Text(
                  subject ?? "",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
              ),
              5.horizontalSpacing,
              SizedBox(
                width: Get.width * 0.25,
                child:  Text(
                  teacher ?? "",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
              ),
              5.horizontalSpacing,
              SizedBox(
                width: Get.width * 0.25,
                child:  Text(
                  lectureType ?? "",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
              ),
            ],
          ),
          10.verticalSpacing,
          CustomDivider(
            width: Get.width,
            color: AppColors.profileDividerColor,
          )
        ],
      ),
    );
  }
}
