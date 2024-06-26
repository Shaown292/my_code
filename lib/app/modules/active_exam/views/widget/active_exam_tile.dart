import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/time_date_tile.dart';

class ActiveExamTile extends StatelessWidget {
  final String? subject;
  final String? title;
  final String? startingTime;
  final String? endingTime;
  final String? activeStatus;
  final Color? color;
  final Color? activeStatusColor;
  final String? startDate;
  final String? endDate;

  const ActiveExamTile({
    super.key,
    this.subject,
    this.color,
    this.startingTime,
    this.endingTime,
    this.activeStatus,
    this.activeStatusColor,
    this.title,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: const TextStyle(
                color: AppColors.profileValueColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Subject".tr,
                value: subject,
                width: Get.width * 0.18,
                titleTextStyle: AppTextStyle.homeworkTitle,
                valueTextStyle: AppTextStyle.homeworkTitle,
              ),
              TimeAndDateTile(
                title: "Start".tr,
                date: startDate ?? "",
                time: "(${startingTime ?? ''})",

              ),
              TimeAndDateTile(
                title: "End".tr,
                date: endDate ?? "",
                time: "(${endingTime ?? ''})",
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Active".tr,
                      style: AppTextStyle.notificationText,
                    ),
                    5.verticalSpacing,
                    activeStatus != null
                        ? Container(
                      width: 60,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: activeStatusColor ??
                                    AppColors.homeworkStatusRedColor),
                            child: Center(
                              child: Text(
                                activeStatus ?? "",
                                style: AppTextStyle.textStyle10WhiteW300,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
