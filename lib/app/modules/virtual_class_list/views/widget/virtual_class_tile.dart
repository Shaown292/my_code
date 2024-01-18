import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class VirtualClassTile extends StatelessWidget {
  final String? topic;
  final String? startingTime;
  final String? duration;
  final String? roomNumber;
  final String? buildingName;
  final String? meetingId;
  final String? activeStatus;
  final Color? activeStatusColor;
  final Function()? onTap;
  final Function()? onTapForCopy;

  const VirtualClassTile({
    super.key,
    this.topic,
    this.startingTime,
    this.duration,
    this.roomNumber,
    this.buildingName,
    this.meetingId,
    this.onTap, this.activeStatusColor, this.activeStatus, this.onTapForCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.parentsCardBorderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.verticalSpacing,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic ?? "",
                              style: AppTextStyle.fontSize14VioletW600,
                            ),
                            10.verticalSpacing,
                            Text(
                              "Start: $startingTime ($duration min) ",
                              style: AppTextStyle.fontSize12GreyW400,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: activeStatusColor,
                              ),
                              child: Text(
                                activeStatus ?? "",
                                style: AppTextStyle.textStyle12WhiteW400,
                              ),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              10.verticalSpacing,
              CustomDivider(
                width: Get.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Meeting Passcode: $meetingId" ,
                    style: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: onTapForCopy,
                      child: const Icon(Icons.content_copy, color: AppColors.teacherTextColor, size: 20,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
