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
  final Function()? onDetailsTap;
  final Function()? evaluationOnTap;
  final bool isEvaluation;
  final int? studentClass;
  final int? studentSection;

  const HomeworkTile({
    super.key,
    this.createDate,
    this.submissionDate,
    this.evaluation,
    this.marks,
    this.subject,
    this.onDetailsTap,
    this.evaluationOnTap,
    this.isEvaluation = false, this.studentClass, this.studentSection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.12,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.profileCardBackgroundColor),
                  child: Center(
                    child: Text(
                      studentClass.toString(),
                      style: AppTextStyle.textStyle12WhiteW400,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                  child: const VerticalDivider(
                    color: AppColors.transportDividerColor,
                    thickness: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: Get.width * 0.14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.homeworkStatusGreenColor),
                  child: Center(
                    child: Text(
                      studentSection.toString(),
                      style: AppTextStyle.textStyle12WhiteW400,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                  child: const VerticalDivider(
                    color: AppColors.transportDividerColor,
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.14,
                  child: Text(
                    subject ?? "",
                    style: const TextStyle(
                      color: AppColors.profileTitleColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                  child: const VerticalDivider(
                    color: AppColors.transportDividerColor,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       InkWell(
                        onTap: onDetailsTap,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.appButtonColor,
                          ),
                          child: Center(
                            child: Text(
                               "Details".tr,
                              style: AppTextStyle.textStyle12WhiteW400,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: evaluationOnTap,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.appButtonColor,
                          ),
                          child: Center(
                            child: Text(
                              "Evaluation".tr,
                              style: AppTextStyle.textStyle12WhiteW400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.transportDividerColor,
        )
      ],
    );

  }
}
