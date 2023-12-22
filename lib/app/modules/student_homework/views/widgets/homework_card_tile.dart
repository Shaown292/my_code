import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';

class HomeworkCardTile extends StatelessWidget {
  final String? subject;
  final String? created;
  final String? submission;
  final String? evaluation;
  final String? status;
  final String? marks;
  final Color? statusColor;
  final Color? backgroundColor;
  final Function()? onTap;

  const HomeworkCardTile({
    super.key,
    this.subject,
    this.created,
    this.submission,
    this.evaluation,
    this.status,
    this.marks,
    this.statusColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject ?? "Subject",
                  style: AppTextStyle.homeworkSubject,
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
                )
              ],
            ),
            20.verticalSpacing,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumnTile(
                      title: "Created",
                      value: created,
                      width: Get.width * 0.2,
                    ),
                    ColumnTile(
                      title: "Submission",
                      value: submission,
                      width: Get.width * 0.22,
                    ),
                    ColumnTile(
                      title: "Evaluation",
                      value: evaluation,
                      width: Get.width * 0.2,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status",
                            style: AppTextStyle.fontSize13BlackW400,
                          ),
                          8.verticalSpacing,
                          status != null
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: statusColor,),
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
                    ),
                  ],
                ),
                10.verticalSpacing,
                ColumnTile(
                  title: "Marks",
                  value: marks,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


