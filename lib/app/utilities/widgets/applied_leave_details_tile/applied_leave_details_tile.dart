import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../colum_tile/column_tile.dart';
import '../common_widgets/custom_divider.dart';

class AppliedLeaveDetailsTile extends StatelessWidget {
  final Color? color;
  final Color? statusColor;
  final String? leaveType;
  final String? approveStatus;
  final String? applyDate;
  final String? leaveFrom;
  final String? leaveTo;
  final String? status;
  final Function()? onTap;

  const AppliedLeaveDetailsTile({
    super.key,
    this.color,
    this.leaveType,
    this.applyDate,
    this.leaveFrom,
    this.leaveTo,
    this.status,
    this.statusColor,
    this.approveStatus,
    this.onTap,
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
                leaveType ?? "title",
                style: AppTextStyle.fontSize14lightBlackW400,
              ),
               InkWell(
                onTap: onTap,
                child: const Column(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                value: leaveTo,
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
                    width: 60,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: statusColor ?? AppColors.homeworkStatusRedColor),
                    child: Center(
                      child: Text(
                        approveStatus ?? "",
                        style: AppTextStyle.textStyle12WhiteW400,
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
