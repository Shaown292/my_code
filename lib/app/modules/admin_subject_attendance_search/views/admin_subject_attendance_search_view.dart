import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_controller.dart';

class AdminSubjectAttendanceSearchView
    extends GetView<AdminSubjectAttendanceSearchController> {
  const AdminSubjectAttendanceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Subject Attendance Search",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
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
                    : CustomDropdown(
                        dropdownValue: controller.subjectList.isEmpty
                            ? controller.subjectNullValue.value
                            : controller.subjectInitialValue.value,
                        dropdownList: controller.subjectList,
                        changeDropdownValue: (v) {
                          controller.sectionInitialValue.value = v!;
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
                const Spacer(),
                PrimaryButton(
                  text: "Search",
                  onTap: () {},
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
