import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/book_list/views/widget/search_field.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_list_controller.dart';

class TeHomeworkListView extends GetView<TeHomeworkListController> {
  const TeHomeworkListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Homework List".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: SearchField(
                controller: controller.searchController,
                onChange: (searchKey) {},
                hintTextStyle: AppTextStyle.fontSize12GreyW400,
                icon: controller.searchController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          controller.searchController.clear();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.profileDividerColor,
                          size: 20,
                        ),
                      )
                    : Icon(
                        Icons.search,
                        color: AppColors.profileDividerColor,
                        size: 20,
                      ),
              ),
            ),
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
            Obx(
              () => controller.loadingController.isLoading
                  ? const Expanded(child: LoadingWidget())
                  : controller.teacherHomeworkList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: controller.teacherHomeworkList.length,
                            itemBuilder: (context, index) {
                              return HomeworkTile(
                                studentClass: controller
                                    .teacherHomeworkList[index].classId,
                                studentSection: controller
                                    .teacherHomeworkList[index].sectionId,
                                subject: controller
                                    .teacherHomeworkList[index].subjectName,
                                evaluationOnTap: () {
                                  if (controller.teacherHomeworkList[index]
                                              .classId ==
                                          null ||
                                      controller.teacherHomeworkList[index]
                                              .sectionId ==
                                          null) {
                                    showBasicFailedSnackBar(
                                        message: 'No Evaluation Found.');
                                  } else {
                                    Get.toNamed(Routes.TE_HOMEWORK_EVALUATION,
                                        arguments: {
                                          'class_id': controller
                                              .teacherHomeworkList[index]
                                              .classId,
                                          'section_id': controller
                                              .teacherHomeworkList[index]
                                              .sectionId,
                                          'homework_id': controller
                                              .teacherHomeworkList[index].id,
                                          'subject_name': controller
                                              .teacherHomeworkList[index]
                                              .subjectName,
                                          'assign_date': controller
                                              .teacherHomeworkList[index]
                                              .assignDate,
                                          'submission_date': controller
                                              .teacherHomeworkList[index]
                                              .submissionDate,
                                          'evaluation': controller
                                              .teacherHomeworkList[index]
                                              .evaluation,
                                          'marks': controller
                                              .teacherHomeworkList[index].marks,
                                          'file': controller
                                              .teacherHomeworkList[index].file,
                                        });
                                  }
                                },
                                onDetailsTap: (){
                                  controller.showHomeworkDetailsBottomSheet(index:index, bottomSheetBackgroundColor: Colors.white);
                                },
                              );
                            },
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
