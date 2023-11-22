import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../controllers/admin_add_room_controller.dart';

class AdminAddRoomView extends GetView<AdminAddRoomController> {
  const AdminAddRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => InfixEduScaffold(
        title: "Add Room",
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
                        hintText: "Room No",
                        fillColor: Colors.white,
                        controller: controller.roomNoController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Number of Bed",
                        fillColor: Colors.white,
                        controller: controller.numberOfBedController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Cost Per Bed",
                        fillColor: Colors.white,
                        controller: controller.costPerBedController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      CustomDropdown(
                        dropdownValue: controller.dormitoryValue.value,
                        scheduleList: controller.dormitoryList,
                        changeDropdownValue: (v) {
                          controller.dormitoryValue.value = v!;
                        },
                      ),
                      10.verticalSpacing,
                      CustomDropdown(
                        dropdownValue: controller.roomTypeValue.value,
                        scheduleList: controller.roomTypeValueList,
                        changeDropdownValue: (v) {
                          controller.roomTypeValue.value = v!;
                        },
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Description",
                        fillColor: Colors.white,
                        controller: controller.descriptionController,
                        hintTextStyle: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      30.verticalSpacing,
                      PrimaryButton(
                        text: "Save",
                        onTap: () {
                          debugPrint(
                              "Dropdown value is :::::::: ${controller.dormitoryValue}"
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
