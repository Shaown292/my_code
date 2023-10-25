import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';

class ExamResultTile extends StatelessWidget {
  final String? subject;
  final String? title;
  final String? startingTime;
  final String? endingTime;
  final String? activeStatus;
  final Color? color;
  final Color? activeStatusColor;

  const ExamResultTile({
    super.key,
    this.color,
    this.subject,
    this.startingTime,
    this.endingTime,
    this.activeStatus,
    this.activeStatusColor, this.title,
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
            title ?? "Title",

            style: AppTextStyle.fontSize14lightViolateW400,
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: "Title",
                value: title,
              ),
              ColumnTile(
                title: "Start",
                value: startingTime,
              ),
              ColumnTile(
                title: "End",
                value: endingTime,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status",
                    style: AppTextStyle.homeworkElements,
                  ),
                  5.verticalSpacing,
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: activeStatusColor ??
                            AppColors.homeworkStatusRedColor),
                    child: Center(
                      child: Text(
                        activeStatus ?? "",
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
