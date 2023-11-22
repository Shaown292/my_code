import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_dormitory_controller.dart';

class AdminAddDormitoryView extends GetView<AdminAddDormitoryController> {
  const AdminAddDormitoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Dormitory",
        body: CustomBackground(
          customWidget: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: Column(
                    children: [
                      20.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Dormitory Name",
                        fillColor: Colors.white,
                        controller: controller.dormitoryNameController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Intake",
                        fillColor: Colors.white,
                        controller: controller.dormitoryIntakeController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Address",
                        fillColor: Colors.white,
                        controller: controller.dormitoryAddressController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      CustomDropdown(
                        dropdownValue: controller.dropdownValue.value,
                        scheduleList: controller.dropdownList,
                        changeDropdownValue: (v) {
                          controller.dropdownValue.value = v!;
                          controller.dormitoryType.value = v[0];
                        },
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Description",
                        fillColor: Colors.white,
                        controller: controller.dormitoryDescriptionController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      30.verticalSpacing,
                      Obx(() => controller.loadingController.isLoading
                          ? const Column(
                              children: [
                                LoadingWidget(),
                              ],
                            )
                          : PrimaryButton(
                              text: "Save",
                              onTap: () {
                                controller.dormitoryType.value =
                                    controller.dropdownValue.value[0];
                                if (controller.validation()) {
                                  controller.addDormitory();
                                }
                              },
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
