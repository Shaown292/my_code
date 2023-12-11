import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/te_add_homework_controller.dart';

class TeAddHomeworkView extends GetView<TeAddHomeworkController> {
  const TeAddHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Homework",
        body: CustomBackground(
          customWidget: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  CustomDropdown(
                    dropdownValue: controller.classInitialValue.value,
                    dropdownList: controller.classList,
                    changeDropdownValue: (value) {
                      controller.classInitialValue.value = value!;
                    },
                  ),
                  10.verticalSpacing,
                  CustomDropdown(
                    dropdownValue: controller.sectionInitialValue.value,
                    dropdownList: controller.sectionList,
                    changeDropdownValue: (value) {
                      controller.sectionInitialValue.value = value!;
                    },
                  ),
                  10.verticalSpacing,
                  CustomDropdown(
                    dropdownValue: controller.sectionInitialValue.value,
                    dropdownList: controller.sectionList,
                    changeDropdownValue: (value) {
                      controller.sectionInitialValue.value = value!;
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
                    hintText: "Assign Date *",
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
                    hintText: "Submission Date *",
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
                    "${controller.file.value.path.isNotEmpty ? controller.file : 'Select File'}",
                    fillColor: Colors.white,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Browse",
                            style: AppTextStyle.fontSize12lightViolateW400,
                          ),
                          CustomDivider(
                            width: 42,
                            height: 1,
                            color: AppColors.profileValueColor,
                          ),
                        ],
                      ),
                    ),
                    iconOnTap: () {
                      controller.pickFile();
                      debugPrint("Browser ::: ${controller.file}");
                    },
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.marksTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Marks",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    maxLine: 3,
                    iconOnTap: () {
                      debugPrint("Browser");
                    },
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.descriptionTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Description",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    maxLine: 3,
                    iconOnTap: () {
                      debugPrint("Browser");
                    },
                  ),
                  30.verticalSpacing,
                  PrimaryButton(
                    text: "Save",
                    onTap: (){},
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
