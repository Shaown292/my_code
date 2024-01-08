import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_nav_button/bottom_nav_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_controller.dart';

class AdminSubjectAttendanceSearchView
    extends GetView<AdminSubjectAttendanceSearchController> {
  const AdminSubjectAttendanceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Subject Attendance Search".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Student Class List
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
                                .studentClassId.value = v.groupId;
                            controller.adminStudentsSearchController
                                .getStudentSectionList(
                                    classId: controller
                                        .adminStudentsSearchController
                                        .studentClassId
                                        .value);
                          },
                        ),
              
                  /// Student Section List
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
                                .studentSectionId.value = v.groupId;
                            controller.adminStudentsSearchController
                                .getAdminStudentSubjectList(
                              classId: controller.adminStudentsSearchController
                                  .studentClassId.value,
                              sectionId: controller.adminStudentsSearchController
                                  .studentSectionId.value,
                            );
                          },
                        ),
              
                  /// Student Subject List
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
                            controller.adminStudentsSearchController
                                .studentSubjectId.value = v.groupId;
                          },
                        ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.selectDate();
                    },
                    readOnly: true,
                    controller: controller.selectedDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Select Date *",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavBar:   BottomNavButton(
          text: "Search".tr,
          onTap: () {
            if(controller.validation()){
              Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_LIST,
                  arguments: {
                    'class_id': controller.adminStudentsSearchController
                        .studentClassId.value,
                    'section_id': controller.adminStudentsSearchController
                        .studentSectionId.value,
                    'subject_id': controller.adminStudentsSearchController
                        .studentSubjectId.value,
                    'date': controller.selectedDateTextController.text,
                  });
            }
          },
        ),
      ),
    );
  }
}
