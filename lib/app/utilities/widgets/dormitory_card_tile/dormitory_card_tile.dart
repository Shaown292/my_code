import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../colum_tile/column_tile.dart';

class DormitoryCardTile extends StatelessWidget {
  final String? dormitoryName;
  final String? roomNoName;
  final String? roomType;
  final int? numberOfBed;
  final int? cost;
  final String? activeStatus;
  final Color? color;
  final Color? activeStatusColor;
  final bool isAdminRoomList;

  const DormitoryCardTile({
    super.key,
    this.dormitoryName,
    this.numberOfBed,
    this.cost,
    this.activeStatus,
    this.color,
    this.activeStatusColor,
    this.roomNoName,
    this.isAdminRoomList = false,
    this.roomType,
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
            dormitoryName ?? AppText.noDataAvailable,
            style: AppTextStyle.fontSize14lightBlackW400,
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: isAdminRoomList ? "Room Name".tr : "Room no".tr,
                value: roomNoName ?? "",
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "No. Of Bed".tr,
                value: "${numberOfBed ?? ""}",
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "Cost".tr,
                value: "${cost ?? ""}",
                width: Get.width * 0.2,
              ),
              isAdminRoomList
                  ? ColumnTile(
                      title: "Room Type".tr,
                      value: roomType ?? "",
                      width: Get.width * 0.2,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "Status".tr,
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
            color: AppColors.customDividerColor,
          )
        ],
      ),
    );
  }
}
