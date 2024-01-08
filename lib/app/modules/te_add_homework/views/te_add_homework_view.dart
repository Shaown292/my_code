import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../controllers/te_add_homework_controller.dart';

class TeAddHomeworkView extends GetView<TeAddHomeworkController> {
  const TeAddHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Homework".tr,
        body: CustomBackground(
          customWidget: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    '${"Select".tr} ${"Class".tr}*',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.verticalSpacing,

                  /// Class Dropdown
                  controller.classLoader.value
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.teacherClassInitialValue.value,
                          dropdownList: controller.teacherClassList,
                          changeDropdownValue: (value) {
                            controller.teacherClassInitialValue.value = value!;
                            controller.teacherClassId.value = value.groupId;
                            controller.getTeacherSubjectList(
                                classId: controller.teacherClassId.value);
                          },
                        ),
                  10.verticalSpacing,

                   Text(
                    '${"Select".tr} ${"Subject".tr}*',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.verticalSpacing,

                  /// subject Dropdown
                  controller.subjectLoader.value
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.teacherSubjectInitialValue.value,
                          dropdownList: controller.teacherSubjectList,
                          changeDropdownValue: (value) {
                            controller.teacherSubjectInitialValue.value =
                                value!;
                            controller.teacherSubjectId.value = value.groupId;
                            controller.getTeacherSectionList(
                                classId: controller.teacherClassId.value,
                                subjectId: controller.teacherSubjectId.value);
                          },
                        ),
                  10.verticalSpacing,

                   Text(
                    '${"Select".tr} ${"Section".tr}*',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.verticalSpacing,

                  /// Class Dropdown
                  controller.sectionLoader.value
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.teacherSectionInitialValue.value,
                          dropdownList: controller.teacherSectionList,
                          changeDropdownValue: (value) {
                            controller.teacherSectionInitialValue.value =
                                value!;
                            controller.teacherSectionId.value = value.groupId;
                          },
                        ),

                  10.verticalSpacing,
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.assignDate();
                    },
                    readOnly: true,
                    controller: controller.assignDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Assign Date".tr} *",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.submissionDate();
                    },
                    readOnly: true,
                    controller: controller.submissionDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Submission Date".tr} *",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText:
                        "${controller.homeworkFile.value.path.isNotEmpty ? controller.homeworkFile : 'Select File'.tr}",
                    fillColor: Colors.white,
                    suffixIcon:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Browse".tr,
                            style: AppTextStyle.fontSize12lightViolateW400,
                          ),
                          const CustomDivider(
                            width: 42,
                            height: 1,
                            color: AppColors.profileValueColor,
                          ),
                        ],
                      ),
                    ),
                    iconOnTap: () {
                      controller.pickFile();
                      debugPrint("Browser ::: ${controller.homeworkFile}");
                    },
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.marksTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Marks".tr,
                    textInputType: TextInputType.number,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    iconOnTap: () {
                      debugPrint("Browser");
                    },
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.descriptionTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Description".tr,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    maxLine: 3,
                    iconOnTap: () {
                      debugPrint("Browser");
                    },
                  ),
                  30.verticalSpacing,
                  controller.loadingController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: () {
                            if (controller.validation()) {
                              controller.addTeacherHomework();
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
