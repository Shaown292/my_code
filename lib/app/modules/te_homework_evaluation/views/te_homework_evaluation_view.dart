import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_evaluation_controller.dart';

class TeHomeworkEvaluationView extends GetView<TeHomeworkEvaluationController> {
  const TeHomeworkEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "${"Homework".tr} ${"Evaluation".tr}",
      body: CustomBackground(
        customWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.09,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                color: AppColors.profileCardBackgroundColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.12,
                    child: Text(
                      "Class".tr,
                      style: AppTextStyle.textStyle12WhiteW500,
                    ),
                  ),
                  const VerticalDivider(
                    color: AppColors.profileTitleColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    width: Get.width * 0.14,
                    child: Text(
                      "Section".tr,
                      style: AppTextStyle.textStyle12WhiteW500,
                    ),
                  ),
                  const VerticalDivider(
                    color: AppColors.profileTitleColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    width: Get.width * 0.14,
                    child: Text(
                      "Subject".tr,
                      style: AppTextStyle.textStyle12WhiteW500,
                    ),
                  ),
                  const VerticalDivider(
                    color: AppColors.profileTitleColor,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            HomeworkTile(
              evaluationOnTap: () => controller.file.value != null
                  ? FileDownloadUtils().downloadFiles(
                      url: controller.file.value!,
                      title: controller.subjectName.value ?? '')
                  : showBasicFailedSnackBar(message: 'No file found.'),
              subject: controller.subjectName.value ?? '',
              createDate: controller.assignDate.value,
              submissionDate: controller.submissionDate.value,
              evaluation: controller.evaluation.value ?? 'N/A',
              marks: controller.marks.value.toString(),
              studentSection: controller.sectionId.value,
              studentClass: controller.clasId.value,
            ),
            10.verticalSpacing,
            Obx(
              () => controller.isLoading.value
                  ? const SecondaryLoadingWidget()
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 15),
                      child: Text(
                        controller.evaluationSubjectList.first.subjectName ??
                            'Subject'.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
                          // Step 2 SEE HERE
                          shadows: [
                            Shadow(
                                offset: Offset(0, -5),
                                color: AppColors.syllabusTextColorBlack)
                          ],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
