import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../controllers/admin_subject_attendance_search_individual_controller.dart';

class AdminSubjectAttendanceSearchIndividualView
    extends GetView<AdminSubjectAttendanceSearchIndividualController> {
  const AdminSubjectAttendanceSearchIndividualView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Subject Wise Attendance Search",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Obx(
            () => Column(
              children: [
                controller.adminStudentsSearchController.loadingController
                        .isLoading
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : DuplicateDropdown(
                        dropdownValue: controller
                                .adminStudentsSearchController.classList.isEmpty
                            ? controller.classNullValue.value
                            : controller
                                .adminStudentsSearchController.classValue.value,
                        dropdownList:
                            controller.adminStudentsSearchController.classList,
                        changeDropdownValue: (v) {
                          controller.adminStudentsSearchController.classValue
                              .value = v!;
                          controller.adminStudentsSearchController
                              .getStudentSectionList(
                                  classId: controller
                                      .adminStudentsSearchController
                                      .studentClassId
                                      .value);
                        },
                      ),
                10.verticalSpacing,
                controller.adminStudentsSearchController.sectionLoader.value
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : DuplicateDropdown(
                        dropdownValue: controller.adminStudentsSearchController
                                .sectionList.isEmpty
                            ? controller.sectionNullValue.value
                            : controller.adminStudentsSearchController
                                .sectionValue.value,
                        dropdownList: controller
                            .adminStudentsSearchController.sectionList,
                        changeDropdownValue: (v) {
                          controller.adminStudentsSearchController.sectionValue
                              .value = v!;
                          controller.adminStudentsSearchController
                              .getAdminStudentSubjectList(
                            classId: controller.adminStudentsSearchController
                                .studentClassId.value,
                            sectionId: controller.adminStudentsSearchController
                                .studentSectionId.value,
                          );
                        },
                      ),
                10.verticalSpacing,
                controller.adminStudentsSearchController.subjectLoader.value
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : DuplicateDropdown(
                        dropdownValue: controller.adminStudentsSearchController
                                .subjectList.isEmpty
                            ? controller.subjectNullValue.value
                            : controller.adminStudentsSearchController
                                .subjectValue.value,
                        dropdownList: controller
                            .adminStudentsSearchController.subjectList,
                        changeDropdownValue: (v) {
                          controller.adminStudentsSearchController.subjectValue
                              .value = v!;
                        },
                      ),
                10.verticalSpacing,
                CustomTextFormField(
                  controller: controller.nameTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Name",
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  controller: controller.rollTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Roll",
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                ),
                const Spacer(),
                controller.searchLoader.value ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)) : PrimaryButton(
                  text: "Search",
                  onTap: () {
                    controller.getSearchStudentDataList(
                      classId: controller.adminStudentsSearchController.studentClassId.value,
                      sectionId: controller.adminStudentsSearchController.studentSectionId.value,
                      subjectId: controller.adminStudentsSearchController.studentSubjectId.value,
                      rollNo: controller.rollTextController.text,
                      name: controller.nameTextController.text,
                    );
                  },
                ),
                50.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
