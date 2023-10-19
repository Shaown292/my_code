import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_homework/views/widgets/status_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    columnTile("Created", created ?? ""),
                    columnTile("Submission", submission ?? ""),
                    columnTile("Evaluation", evaluation ?? "N/A"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Status",
                          style: AppTextStyle.homeworkElements,
                        ),

                        StatusWidget(
                          value: status ?? "",
                          color: statusColor,
                        )
                      ],
                    ),
                  ],
                ),
                10.verticalSpacing,
                columnTile("Marks", marks ?? ""),
              ],
            ),
            20.verticalSpacing,
          ],
        ),
      ),
    );
  }
}

Widget columnTile(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTextStyle.homeworkElements,
      ),
      8.verticalSpacing,
      SizedBox(
        height: Get.height * 0.025,
        child: Text(
          value,
          style: AppTextStyle.homeworkElements,
        ),
      ),
    ],
  );
}