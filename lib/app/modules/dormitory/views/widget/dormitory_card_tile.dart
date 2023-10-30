import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';

class DormitoryCardTile extends StatelessWidget {

  final String? hostelType;
  final String? roomNo;
  final int? numberOfBed;
  final int? cost;
  final String? activeStatus;
  final Color? color;
  final Color? activeStatusColor;

  const DormitoryCardTile({
    super.key,
    this.hostelType,
    this.numberOfBed,
    this.cost,
    this.activeStatus,
    this.color,
    this.activeStatusColor,
    this.roomNo,
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
            hostelType ?? AppText.noDataAvailable,
            style: AppTextStyle.fontSize14lightViolateW400,
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: "Room no",
                value: roomNo ?? AppText.noDataAvailable,
              ),
              ColumnTile(
                title: "No. Of Bed",
                value: "${numberOfBed ?? AppText.noDataAvailable}",
              ),
              ColumnTile(
                title: "Cost",
                value: "${cost ?? AppText.noDataAvailable}",
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
                            AppColors.homeworkStatusGreenColor),
                    child: Center(
                      child: Text(
                        activeStatus ?? AppText.noDataAvailable,
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          10.verticalSpacing,
          CustomDivider(
            width: Get.width,
            color: AppColors.dormitoryDividerColor,
          )
        ],
      ),
    );
  }
}
