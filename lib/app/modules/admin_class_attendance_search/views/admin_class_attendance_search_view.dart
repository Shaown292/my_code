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

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_controller.dart';

class AdminClassAttendanceSearchView
    extends GetView<AdminClassAttendanceSearchController> {
  const AdminClassAttendanceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Class Attendance Search",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              children: [
                /// Class Dropdown
                controller.adminStudentsSearchController.loadingController
                        .isLoading
                    ? const CircularProgressIndicator()
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

                /// Section Dropdown
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
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                  suffixIcon: Image.asset(
                    ImagePath.calender,
                    color: AppColors.profileValueColor,
                  ),
                ),
                const Spacer(),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : PrimaryButton(
                        text: "Search",
                        onTap: () {
                          if (controller.validation()) {
                            controller.getStudentAttendanceList(
                              studentClassId: controller
                                  .adminStudentsSearchController
                                  .studentClassId
                                  .value,
                              studentSectionId: controller
                                  .adminStudentsSearchController
                                  .studentSectionId
                                  .value,
                              selectedDate:
                                  controller.selectedDateTextController.text,
                            );
                          }
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
