import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';
import 'package:intl/number_symbols_data.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                  child: Column(
                    children: [
                      20.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Dormitory Name",
                        fillColor: Colors.white,
                        controller: controller.dormitoryNameController,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Intake",
                        fillColor: Colors.white,
                        controller: controller.dormitoryIntake,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Address",
                        fillColor: Colors.white,
                        controller: controller.dormitoryAddress,
                      ),
                      10.verticalSpacing,
                      CustomDropdown(
                        dropdownValue: controller.dropdownValue.value,
                        scheduleList: controller.dropdownList,
                        changeDropdownValue: (v) {
                          controller.dropdownValue.value = v!;
                        },
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Description",
                        fillColor: Colors.white,
                        controller: controller.dormitoryNote,
                      ),
                      30.verticalSpacing,
                      PrimaryButton(
                        text: "Save",
                        onTap: () {
                          debugPrint(
                            "Dropdown value is :::::::: ${controller.dropdownValue}"
                          );
                          controller.validation();
                        },
                      ),
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
