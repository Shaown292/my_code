import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class HomeworkTile extends StatelessWidget {
  final String? createDate;
  final String? submissionDate;
  final String? evaluation;
  final String? marks;
  final String? subject;
  final Function()? onTap;
  final Function()? evaluationOnTap;
  final bool isEvaluation;

  const HomeworkTile({
    super.key,
    this.createDate,
    this.submissionDate,
    this.evaluation,
    this.marks,
    this.subject,
    this.onTap,
    this.evaluationOnTap,
    this.isEvaluation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject ?? "",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              InkWell(
                onTap: onTap,
                child: isEvaluation
                    ? InkWell(
                        onTap: evaluationOnTap,
                        child: Image.asset(
                          ImagePath.download,
                          scale: 4,
                          color: AppColors.primaryColor,
                        ),
                      )
                    :  Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Evaluation".tr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.transparent,
                            // Step 2 SEE HERE
                            shadows: [
                              Shadow(
                                  offset: Offset(0, -5),
                                  color: AppColors.primaryColor)
                            ],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Created".tr,
                value: createDate,
              ),
              ColumnTile(
                title: "Submission".tr,
                value: submissionDate,
              ),
              ColumnTile(
                title: "Evaluation".tr,
                value: evaluation,
              ),
              ColumnTile(
                title: "Marks".tr,
                value: marks,
              ),
            ],
          ),
        ),
        10.verticalSpacing,
        const CustomDivider(
          color: AppColors.customDividerColor,
        )
      ],
    );
  }
}
