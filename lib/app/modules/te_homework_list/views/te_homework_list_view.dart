import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_list_controller.dart';

class TeHomeworkListView extends GetView<TeHomeworkListController> {
  const TeHomeworkListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          InfixEduScaffold(
            title: "Homework List".tr,
            body: CustomBackground(
              customWidget: Column(

                children: [

                  20.verticalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      5.horizontalSpacing,

                      /// Class Dropdown
                      controller.teAddHomeworkController.classLoader.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                        width: Get.width / 3 - 15,
                        height: Get.height * 0.07,
                        child: DuplicateDropdown(
                          borderRadius: 2,
                          dropdownValue: controller.teAddHomeworkController
                              .teacherClassInitialValue.value,
                          dropdownList: controller
                              .teAddHomeworkController.teacherClassList,
                          changeDropdownValue: (value) {
                            controller.teAddHomeworkController
                                .teacherClassInitialValue.value = value!;
                            controller.teAddHomeworkController.teacherClassId
                                .value = value.id;
                            controller.teAddHomeworkController
                                .getTeacherSubjectList(
                                classId: controller
                                    .teAddHomeworkController
                                    .teacherClassId
                                    .value);
                            controller.isDropDownChanged.value == true;
                            controller.filterHomework(
                                classId :controller.teAddHomeworkController.teacherClassId
                                    .value,
                                sectionId:  controller.teAddHomeworkController.teacherSectionId
                                    .value,
                                subjectId : controller.teAddHomeworkController.teacherSubjectId
                                    .value);
                          },
                        ),
                      ),

                      5.horizontalSpacing,

                      /// subject Dropdown
                      controller.teAddHomeworkController.subjectLoader.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                        width: Get.width / 3 - 15,
                        height: Get.height * 0.07,
                        child: DuplicateDropdown(
                          borderRadius: 2,
                          dropdownValue: controller.teAddHomeworkController
                              .teacherSubjectInitialValue.value,
                          dropdownList: controller
                              .teAddHomeworkController.teacherSubjectList,
                          changeDropdownValue: (value) {
                            controller.teAddHomeworkController
                                .teacherSubjectInitialValue.value = value!;
                            controller.teAddHomeworkController
                                .teacherSubjectId.value = value.id;

                            controller.teAddHomeworkController
                                .getTeacherSectionList(
                                classId: controller
                                    .teAddHomeworkController
                                    .teacherClassId
                                    .value,
                                subjectId: controller
                                    .teAddHomeworkController
                                    .teacherSubjectId
                                    .value);
                            controller.isDropDownChanged.value == true;
                            controller.filterHomework(
                                classId :controller.teAddHomeworkController.teacherClassId
                                    .value,
                                sectionId:  controller.teAddHomeworkController.teacherSectionId
                                    .value,
                                subjectId : controller.teAddHomeworkController.teacherSubjectId
                                    .value);
                          },
                        ),
                      ),

                      5.horizontalSpacing,
                      /// Section Dropdown
                      controller.teAddHomeworkController.sectionLoader.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                        width: Get.width / 3 - 15,
                        height: Get.height * 0.07,
                        child: DuplicateDropdown(
                          borderRadius: 2,
                          dropdownValue: controller.teAddHomeworkController
                              .teacherSectionInitialValue.value,
                          dropdownList: controller
                              .teAddHomeworkController.teacherSectionList,
                          changeDropdownValue: (value) {
                            controller.teAddHomeworkController
                                .teacherSectionInitialValue.value = value!;
                            controller.teAddHomeworkController
                                .teacherSectionId.value = value.id;
                            controller.isDropDownChanged.value == true;
                            controller.filterHomework(
                                classId :controller.teAddHomeworkController.teacherClassId
                                    .value,
                                sectionId:  controller.teAddHomeworkController.teacherSectionId
                                    .value,
                                subjectId : controller.teAddHomeworkController.teacherSubjectId
                                    .value);
                          },
                        ),
                      ),
                      5.horizontalSpacing,
                    ],
                  ),
                  // PrimaryButton(text: "Search", onTap: (){
                  //   controller.searchHomework(controller.teAddHomeworkController.teacherClassId.value, controller.teAddHomeworkController.teacherSectionId.value,controller.teAddHomeworkController.teacherSubjectId.value);
                  // },),
                  30.verticalSpacing,
                  Container(
                    height: Get.height * 0.09,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      color: AppColors.profileCardBackgroundColor,
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
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
                        Container(
                          alignment: Alignment.center,
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
                        Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.15,
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
                        () =>
                controller.isDropDownChanged.value ? controller.searchHomeworkLoader.value
                    ? const Expanded(child: LoadingWidget())
                    : controller.teacherHomeworkList.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    itemCount: controller.teacherHomeworkList.length,
                    itemBuilder: (context, index) {
                      return HomeworkTile(
                        widthOfFirstContainer: Get.width * 0.12,
                        widthOfSecondContainer: Get.width * 0.14,
                        widthOfThirdContainer: Get.width * 0.15,
                        evaluateContainerColor:
                        AppColors.appButtonColor,
                        studentClass: controller
                            .teacherHomeworkList[index].className,
                        studentSection: controller
                            .teacherHomeworkList[index].sectionName,
                        subject: controller
                            .teacherHomeworkList[index].subjectName,
                        onEvaluationTap: () {
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
                                  'class_name': controller
                                      .teacherHomeworkList[index]
                                      .className,
                                  'section_id': controller
                                      .teacherHomeworkList[index]
                                      .sectionId,
                                  'section_name': controller
                                      .teacherHomeworkList[index]
                                      .sectionName,
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
                                      .teacherHomeworkList[index]
                                      .marks,
                                  'file': controller
                                      .teacherHomeworkList[index]
                                      .file,
                                });
                          }
                        },
                        onDetailsTap: () {
                          controller.showHomeworkDetailsBottomSheet(
                              index: index,
                              bottomSheetBackgroundColor:
                              Colors.white);
                        },
                      );
                    },
                  ) ,
                ) : const NoDataAvailableWidget() :   controller.homeworkLoader.value
                     ? const Expanded(child: LoadingWidget())
                     : controller.teacherHomeworkList.isNotEmpty
                     ? Expanded(
                   child: ListView.builder(
                     itemCount: controller.teacherHomeworkList.length,
                     itemBuilder: (context, index) {
                       return HomeworkTile(
                         widthOfFirstContainer: Get.width * 0.12,
                         widthOfSecondContainer: Get.width * 0.14,
                         widthOfThirdContainer: Get.width * 0.15,
                         evaluateContainerColor:
                         AppColors.appButtonColor,
                         studentClass: controller
                             .teacherHomeworkList[index].className,
                         studentSection: controller
                             .teacherHomeworkList[index].sectionName,
                         subject: controller
                             .teacherHomeworkList[index].subjectName,
                         onEvaluationTap: () {
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
                                   'class_name': controller
                                       .teacherHomeworkList[index]
                                       .className,
                                   'section_id': controller
                                       .teacherHomeworkList[index]
                                       .sectionId,
                                   'section_name': controller
                                       .teacherHomeworkList[index]
                                       .sectionName,
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
                                       .teacherHomeworkList[index]
                                       .marks,
                                   'file': controller
                                       .teacherHomeworkList[index]
                                       .file,
                                 });
                           }
                         },
                         onDetailsTap: () {
                           controller.showHomeworkDetailsBottomSheet(
                               index: index,
                               bottomSheetBackgroundColor:
                               Colors.white);
                         },
                       );
                     },
                   ) ,
                 ) : const NoDataAvailableWidget(),

                  ),
                ],
              ),
            ),
          ),
    );
  }
}
