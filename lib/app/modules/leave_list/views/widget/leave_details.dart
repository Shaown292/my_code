import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class LeaveDetails extends StatelessWidget {
  final Color? color;
  final Color? statusColor;
  final String? title;
  final String? statusText;
  final String? applyDate;
  final String? leaveFrom;
  final String? leaveUntil;
  final String? status;

  const LeaveDetails({
    super.key,
    this.color,
    this.title,
    this.applyDate,
    this.leaveFrom,
    this.leaveUntil,
    this.status,
    this.statusColor,
    this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "title",
                style: AppTextStyle.fontSize14lightViolateW400,
              ),
              const InkWell(
                child:  Column(
                  children: [
                    Text(
                      "View",
                      style: AppTextStyle.homeworkView,
                    ),
                    CustomDivider(
                      width: 35,
                      height: 1,
                      color: AppColors.homeworkViewColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Apply Date",
                value: applyDate,
              ),
              ColumnTile(
                title: "From",
                value: leaveFrom,
              ),
              ColumnTile(
                title: "To",
                value: leaveUntil,
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
                        color: statusColor ?? AppColors.homeworkStatusRedColor),
                    child: Center(
                      child: Text(
                        statusText ?? "",
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
