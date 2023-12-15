import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/te_search_class_routine_controller.dart';

class TeSearchClassRoutineView extends GetView<TeSearchClassRoutineController> {
  const TeSearchClassRoutineView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Class Routine",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpacing,
                const Text('Select class*'),
                5.verticalSpacing,
                controller.adminStudentsSearchController.loadingController
                        .isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                    )
                    : DuplicateDropdown(
                        dropdownValue: controller
                            .adminStudentsSearchController.classValue.value,
                        dropdownList:
                            controller.adminStudentsSearchController.classList,
                        changeDropdownValue: (value) {
                          controller.adminStudentsSearchController.classValue
                              .value = value!;
                          controller.adminStudentsSearchController
                              .studentClassId.value = value.id;
                        },
                      ),
                20.verticalSpacing,
                const Text('Select section*'),
                5.verticalSpacing,
                controller.adminStudentsSearchController.sectionLoader.value
                    ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                    )
                    : DuplicateDropdown(
                        dropdownValue: controller
                            .adminStudentsSearchController.sectionValue.value,
                        dropdownList: controller
                            .adminStudentsSearchController.sectionList,
                        changeDropdownValue: (value) {
                          controller.adminStudentsSearchController.sectionValue
                              .value = value!;
                          controller.adminStudentsSearchController
                              .studentSectionId.value = value.id;
                        },
                      ),
                50.verticalSpacing,
                PrimaryButton(
                  text: "Save",
                  onTap: () {
                    Get.toNamed(Routes.TE_SEARCH_CLASS_ROUTINE_LIST);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
