import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

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
      padding: const EdgeInsets.all(15),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leaveType ?? "",
                style: AppTextStyle.fontSize14lightBlackW400,
              ),
               InkWell(
                onTap: onTap,
                child:  Column(
                  children: [
                    Text(
                      "View".tr,
                      style: AppTextStyle.homeworkView,
                    ),
                    const CustomDivider(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Apply Date".tr,
                value: applyDate,
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "From".tr,
                value: leaveFrom,
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "To".tr,
                value: leaveTo,
                width: Get.width * 0.2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Status".tr,
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  15.verticalSpacing,
                  status != null
                      ? Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: statusColor),
                    child: Center(
                      child: Text(
                        status ?? "",
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                  )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
