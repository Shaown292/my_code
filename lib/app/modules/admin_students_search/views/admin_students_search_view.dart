import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_nav_button/bottom_nav_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
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
        title: "Students",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    hintText: "Name",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.rollTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    textInputType: TextInputType.number,
                    hintText: "Roll",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  50.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
        bottomNavBar: controller.searchLoader.value
            ? const SecondaryLoadingWidget(isBottomNav: true,)
            : BottomNavButton(
                text: "Search",
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
    );
  }
}
