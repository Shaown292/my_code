import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../colum_tile/column_tile.dart';

class ShowStatusTile extends StatelessWidget {
  final String? firstTitle;

  final String? secondTitle;
  final String? thirdTitle;
  final String? firstValue;
  final String? secondValue;
  final String? thirdValue;
  final String? status;
  final String? activeStatus;
  final Color? activeStatusColor;

  const ShowStatusTile({
    super.key,
    this.firstTitle,
    this.secondTitle,
    this.thirdTitle,
    this.status,
    this.firstValue,
    this.activeStatus,
    this.activeStatusColor,
    this.secondValue,
    this.thirdValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpacing,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            ColumnTile(
              title: firstTitle,
              value: firstValue,
            ),
            ColumnTile(
              title: secondTitle,
              value: secondValue,
            ),
            ColumnTile(
              title: thirdTitle,
              value: thirdValue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Status".tr,
                  style: AppTextStyle.fontSize13BlackW400,
                ),
                5.verticalSpacing,
                activeStatus != null
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: activeStatusColor),
                        child: Center(
                          child: Text(
                            activeStatus ?? "",
                            style: AppTextStyle.textStyle10WhiteW400,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
        10.verticalSpacing,
        CustomDivider(
          width: Get.width,
          color: AppColors.customDividerColor,
        ),
      ],
    );
  }
}
