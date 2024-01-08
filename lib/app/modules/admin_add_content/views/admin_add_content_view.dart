import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_nav_button/bottom_nav_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_checkbox/custom_checkbox.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_content_controller.dart';

class AdminAddContentView extends GetView<AdminAddContentController> {
  const AdminAddContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Content".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpacing,

                   Text('${"Content Type".tr}*'),
                  5.verticalSpacing,
                  CustomDropdown(
                    dropdownValue: controller.contentInitialValue.value,
                    dropdownList: controller.contentList,
                    changeDropdownValue: (value) {
                      controller.contentInitialValue.value = value!;
                      controller.contentType.value = controller
                          .contentInitialValue.value
                          .substring(0, 2)
                          .toLowerCase();
                    },
                  ),
                  15.verticalSpacing,

                  /// Title
                  CustomTextFormField(
                    controller: controller.titleTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Title".tr}*",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  15.verticalSpacing,
                   Text(
                    "${"Available For".tr}*",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),

                  //All Admin radio button
                  CustomCheckbox(
                    checkboxValue: controller.isAdminSelected.value,
                    checkboxTitle: "All Admin".tr,
                    onChange: (bool? value) {
                      controller.isAdminSelected.value = value!;
                      controller.isStudent.value = true;
                      controller.isAdminSelected.value
                          ? controller.availableForList.add('admin')
                          : controller.availableForList.remove('admin');
                    },
                    shape: const CircleBorder(),
                  ),

                  //student radio button
                  CustomCheckbox(
                    checkboxValue: controller.isStudentSelected.value,
                    checkboxTitle: "Student".tr,
                    onChange: (bool? value) {
                      controller.isStudentSelected.value = value!;
                      controller.isStudent.value = true;
                      controller.isStudentSelected.value
                          ? controller.availableForList.add('student')
                          : controller.availableForList.remove('student');
                    },
                    shape: const CircleBorder(),
                  ),

                  10.verticalSpacing,
                  controller.isStudentSelected.value
                      ? CustomCheckbox(
                          checkboxValue: controller.isAllStudent.value,
                          checkboxTitle: "All Students".tr,
                          onChange: (bool? value) {
                            controller.isAllStudent.value = value!;
                            controller.isStudent.value = false;
                            controller.isAllStudent.value
                                ? controller.allClasses.value = 'on'
                                : controller.allClasses.value = '';
                          },
                        )
                      : const SizedBox(),

                  10.verticalSpacing,

                  /// Student Class List Dropdown
                  controller.isStudentSelected.value &&
                          controller.isAllStudent.value == false
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
                                controller.adminStudentsSearchController
                                    .studentClassId.value = v.groupId;
                              },
                            )
                      : const SizedBox(),
                  10.verticalSpacing,

                  /// Student Section List Dropdown
                  controller.isStudentSelected.value &&
                          controller.isAllStudent.value == false
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
                                controller.adminStudentsSearchController
                                    .studentSectionId.value = v.groupId;
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
                    hintText: "${"Assign Date".tr}*",
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
                        "${controller.contentFile.value.path.isNotEmpty ? controller.contentFile : 'Select File'.tr}",
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
                    },
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  10.verticalSpacing,

                  /// Description
                  CustomTextFormField(
                    controller: controller.descriptionTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Description".tr,
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    minLine: 1,
                    maxLine: 2,
                  ),
                  20.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
        bottomNavBar: controller.saveLoader.value
            ? const SecondaryLoadingWidget(isBottomNav: true,)
            : BottomNavButton(
          text: "Save".tr,
          onTap: () {
            if (controller.validation()) {
              controller.uploadContent();
            }
          },
        ),
      ),
    );
  }
}
