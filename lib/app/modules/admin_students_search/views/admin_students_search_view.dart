import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../controllers/admin_students_search_controller.dart';

class AdminStudentsSearchView extends GetView<AdminStudentsSearchController> {
  const AdminStudentsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Students".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"Select".tr} ${"Class".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.verticalSpacing,
                  /// Student Class List Dropdown
                  controller.loadingController.isLoading
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller.classValue.value,
                          dropdownList: controller.classList,
                          changeDropdownValue: (v) {
                            controller.classValue.value = v!;
                            controller.studentClassId.value = v.id;

                            controller.getStudentSectionList(
                              classId: controller.studentClassId.value,
                            );
                          },
                        ),

                  10.verticalSpacing,
                  Text(
                    "${"Select".tr} ${"Section".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.verticalSpacing,
                  /// Student Section List Dropdown
                  controller.sectionLoader.value
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller.sectionValue.value,
                          dropdownList: controller.sectionList,
                          changeDropdownValue: (v) {
                            controller.sectionValue.value = v!;
                            controller.studentSectionId.value = v.id;
                          },
                        ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.nameTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Name".tr,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.rollTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    textInputType: TextInputType.number,
                    hintText: "Roll".tr,
                    fillColor: Colors.white,
                  ),
                  (Get.height * 0.3).verticalSpacing,
                  controller.searchLoader.value
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: PrimaryButton(
                            text: "Search".tr,
                            onTap: () {
                              controller.getSearchStudentDataList(
                                classId: controller.studentClassId.value,
                                sectionId: controller.studentSectionId.value,
                                rollNo: controller.rollTextController.text,
                                name: controller.nameTextController.text,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
