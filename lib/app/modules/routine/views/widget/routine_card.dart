import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class RoutineCard extends StatelessWidget {

  final String? subject;
  final String? startingTime;
  final String? endingTime;
  final String? roomNumber;
  final String? buildingName;
  final String? instructorName;

  const RoutineCard({
    super.key,
    this.subject,
    this.startingTime,
    this.endingTime,
    this.roomNumber,
    this.buildingName,
    this.instructorName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      subject ?? "",
                      style: AppTextStyle.fontSize14VioletW600,
                    ),
                    5.verticalSpacing,
                     Text(
                      "$startingTime - $endingTime",
                      style: AppTextStyle.fontSize14GreyW400,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.parentsCardBorderColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Room - $roomNumber",
                        style: AppTextStyle.fontSize14GreyW400,
                      ),
                      5.verticalSpacing,
                       Text(
                        buildingName ?? "",
                        style: AppTextStyle.fontSize12lightViolateW400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.verticalSpacing,
            CustomDivider(
              width: Get.width,
            ),
            10.verticalSpacing,
             Text(
              instructorName ?? "",
              style: AppTextStyle.fontSize14lightViolateW400,
            )
          ],
        ),
      ),
    );
  }
}