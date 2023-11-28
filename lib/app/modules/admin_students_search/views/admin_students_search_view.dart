import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomDropdown(
                        dropdownValue: controller.classValue.value,
                        dropdownList: controller.classListDropdown,
                        changeDropdownValue: (v) {
                          controller.classValue.value = v!;
                        },
                      ),
                      10.verticalSpacing,
                      CustomDropdown(
                        dropdownValue: controller.classValue.value,
                        dropdownList: controller.classListDropdown,
                        changeDropdownValue: (v) {
                          controller.classValue.value = v!;
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
                        hintText: "Roll",
                        fillColor: Colors.white,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    PrimaryButton(
                      text: "Search",
                      onTap: () {
                        print('............... ${controller.studentClassId}');
                        // Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH_LIST);
                        controller.getSearchStudentDataList(
                          classId: controller.studentClassId.value,
                        );
                      },
                    ),
                    // 50.verticalSpacing,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
