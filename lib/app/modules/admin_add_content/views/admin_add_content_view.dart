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
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_radio_button/custom_radio_button.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_content_controller.dart';

class AdminAddContentView extends GetView<AdminAddContentController> {
  const AdminAddContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Content",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpacing,
                  // const Text("Content type", style: AppTextStyle.fontSize13BlackW400,),
                  5.verticalSpacing,
                  CustomDropdown(
                    dropdownValue: controller.contentInitialValue.value,
                    dropdownList: controller.contentList,
                  ),
                  10.verticalSpacing,

                  /// Title
                  CustomTextFormField(
                    controller: controller.titleTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Title",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  15.verticalSpacing,
                  const Text(
                    "Available For",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),

                  //All Admin radio button
                  CustomRadioButton(
                    title: "All Admin",
                    value: "All Admin",
                    groupValue: controller.selectedOption.value,
                    onChanged: (value) {
                      controller.selectedOption.value = value!;
                      controller.isStudent.value = false;
                    },
                    activeColor: AppColors.primaryColor,
                  ),

                  //student radio button
                  CustomRadioButton(
                    title: "Student",
                    value: "Student",
                    groupValue: controller.selectedOption.value,
                    onChanged: (value) {
                      controller.selectedOption.value = value!;
                      controller.isStudent.value = true;
                    },
                    activeColor: AppColors.primaryColor,
                  ),

                  10.verticalSpacing,
                  controller.isStudent.value
                      ? Row(
                          children: [
                            16.horizontalSpacing,
                            Checkbox(
                              value: controller.isAllStudent.value,
                              onChanged: (bool? value) {
                                controller.isAllStudent.value = value!;

                              },
                            ),
                            15.horizontalSpacing,
                            const Text(
                              "All Student",
                              style: AppTextStyle.fontSize13BlackW400,
                            ),
                          ],
                        )
                      : const SizedBox(),

                  10.verticalSpacing,

                  /// Student Class List Dropdown
                  controller.isStudent.value && controller.isAllStudent.value == false
                      ? controller.loadingController.isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue: controller
                                      .adminStudentsSearchController
                                      .classList
                                      .isEmpty
                                  ? controller.classNullValue.value
                                  : controller.adminStudentsSearchController
                                      .classValue.value,
                              dropdownList: controller
                                  .adminStudentsSearchController.classList,
                              changeDropdownValue: (v) {
                                controller.adminStudentsSearchController
                                    .classValue.value = v!;
                              },
                            )
                      : const SizedBox(),
                  10.verticalSpacing,

                  /// Student Section List Dropdown
                  controller.isStudent.value && controller.isAllStudent.value == false
                      ? controller.sectionLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue: controller
                                      .adminStudentsSearchController
                                      .sectionList
                                      .isEmpty
                                  ? controller.sectionNullValue.value
                                  : controller.adminStudentsSearchController
                                      .sectionValue.value,
                              dropdownList: controller
                                  .adminStudentsSearchController.sectionList,
                              changeDropdownValue: (v) {
                                controller.adminStudentsSearchController
                                    .sectionValue.value = v!;
                              },
                            )
                      : const SizedBox(),

                  10.verticalSpacing,
                  // assign date
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.selectDate();
                    },
                    readOnly: true,
                    controller: controller.selectedDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Assign Date",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
                  ),
                  10.verticalSpacing,

                  /// Select File
                  CustomTextFormField(
                    enableBorderActive: true,
                    focusBorderActive: true,
                    readOnly: true,
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

                  /// Description
                  CustomTextFormField(
                    controller: controller.descriptionTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Description",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  50.verticalSpacing,
                  PrimaryButton(
                    text: "Save",
                    onTap: () {},
                  ),
                  20.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
