import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

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
          child: Column(
            children: [
              CustomDropdown(
                dropdownValue: controller.classList.isEmpty ? controller.classNullValue.value : controller.classInitialValue.value,
                dropdownList: controller.classList,
                changeDropdownValue: (v) {
                  controller.classInitialValue.value = v!;
                },
              ),
              10.verticalSpacing,
              CustomDropdown(
                dropdownValue: controller.sectionList.isEmpty ? controller.sectionNullValue.value : controller.sectionInitialValue.value,
                dropdownList: controller.sectionList,
                changeDropdownValue: (v) {
                  controller.sectionInitialValue.value = v!;
                },
              ),
              10.verticalSpacing,
              CustomDropdown(
                dropdownValue: controller.subjectList.isEmpty ? controller.subjectNullValue.value : controller.subjectInitialValue.value,
                dropdownList: controller.subjectList,
                changeDropdownValue: (v) {
                  controller.subjectInitialValue.value = v!;
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
              PrimaryButton(
                text: "Search",
                onTap: () {
                  Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_LIST);
                },
              ),
              50.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
