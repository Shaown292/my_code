import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_member_controller.dart';

class AdminAddMemberView extends GetView<AdminAddMemberController> {
  const AdminAddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Member",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: controller.idTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Enter ID",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Role dropdown
                  controller.rolesList.isNotEmpty
                      ? DuplicateDropdown(
                          dropdownValue: controller.rolesDropdownValue.value,
                          dropdownList: controller.rolesList,
                          changeDropdownValue: (value) {
                            controller.rolesDropdownValue.value = value!;
                            controller.rolesId.value = value.id;
                          },
                        )
                      : const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),

                  /// Student or Parents class
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: controller.classList.isEmpty
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : DuplicateDropdown(
                                  dropdownValue:
                                      controller.classDropdownValue.value,
                                  dropdownList: controller.classList,
                                  changeDropdownValue: (value) {
                                    controller.classDropdownValue.value =
                                        value!;
                                    controller.classId.value = value.id;
                                  },
                                ),
                        )
                      : const SizedBox(),

                  /// Student or Parents section
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: DuplicateDropdown(
                            dropdownValue:
                                controller.sectionDropdownValue.value,
                            dropdownList: controller.sectionList,
                            changeDropdownValue: (value) {
                              controller.sectionDropdownValue.value = value!;
                              controller.sectionId.value = value.id;
                            },
                          ),
                        )
                      : const SizedBox(),
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? 0.verticalSpacing
                      : 10.verticalSpacing,

                  /// Member id
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? const SizedBox()
                      : controller.userNameList.isEmpty
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue:
                                  controller.userNameDropdownValue.value,
                              dropdownList: controller.userNameList,
                              changeDropdownValue: (value) {
                                controller.userNameDropdownValue.value = value!;
                                controller.userId.value = value.id;
                              },
                            ),

                  controller.rolesId.value == 2
                      ? controller.studentList.isEmpty
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue:
                                  controller.studentDropdownValue.value,
                              dropdownList: controller.studentList,
                              changeDropdownValue: (value) {
                                controller.studentDropdownValue.value = value!;
                                controller.studentId.value = value.id;
                              },
                            )
                      : const SizedBox(),
                  controller.rolesId.value == 3
                      ? controller.studentList.isEmpty
                      ? const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )
                      : DuplicateDropdown(
                    dropdownValue:
                    controller.parentsDropdownValue.value,
                    dropdownList: controller.parentsList,
                    changeDropdownValue: (value) {
                      controller.parentsDropdownValue.value = value!;
                      controller.parentsId.value = value.id;
                    },
                  )
                      : const SizedBox(),
                  50.verticalSpacing,
                  PrimaryButton(text: "Save", onTap: (){},)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
