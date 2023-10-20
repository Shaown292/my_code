import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/button/primary_button.dart';

class AssignmentCard extends StatelessWidget {
  final String? dueDate;
  final String? assignmentTile;
  final String? assignmentDetails;
  const AssignmentCard({
    super.key,
    this.dueDate,
    this.assignmentTile,
    this.assignmentDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
             assignmentTile ?? "",
              style: AppTextStyle.fontSize16lightViolateW500,
            ),
            5.verticalSpacing,
             Text(
              assignmentDetails ?? "",
              style: const TextStyle(
                  color: AppColors.syllabusTextColor635976,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            10.verticalSpacing,
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFFE3E3E)),
                  child:  Center(
                    child: Text(
                      "Due - $dueDate",
                      style: AppTextStyle.cardTextStyle14WhiteW500,
                    ),
                  ),
                ),
                5.horizontalSpacing,
                const Expanded(
                  child: PrimaryButton(
                    title: "DOWNLOAD",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
