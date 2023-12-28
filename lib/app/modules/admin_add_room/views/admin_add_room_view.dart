import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: Column(
                    children: [
                      20.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Room Name*",
                        fillColor: Colors.white,
                        controller: controller.roomNameTextController,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        textInputType: TextInputType.number,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Number of Bed*",
                        fillColor: Colors.white,
                        controller: controller.numberOfBedTextController,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        textInputType: TextInputType.number,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Cost Per Bed*",
                        fillColor: Colors.white,
                        controller: controller.costPerBedTextController,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      ),
                      10.verticalSpacing,
                      controller.loadingController.isLoading
                          ? const CircularProgressIndicator()
                          : DuplicateDropdown(
                        dropdownValue: controller.dormitoryValue.value,
                        dropdownList: controller.dormitoryList,
                        changeDropdownValue: (v) {
                          controller.dormitoryValue.value = v;
                          controller.dormitoryId.value = v.groupId;
                        },
                      ),
                      10.verticalSpacing,
                      controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : DuplicateDropdown(
                        dropdownValue: controller.roomTypeValue.value,
                        dropdownList: controller.roomTypeList,
                        changeDropdownValue: (v) {
                          controller.roomTypeValue.value = v;
                          controller.roomTypeId.value = v.groupId;
                        },
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Description",
                        fillColor: Colors.white,
                        controller: controller.descriptionTextController,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      ),
                      30.verticalSpacing,
                      controller.saveLoader.value
                          ? const CircularProgressIndicator(color: AppColors.primaryColor,)
                          : PrimaryButton(
                        text: "Save",
                        onTap: () {
                          if (controller.validation()) {
                            controller.addDormitoryRoom();
                          }
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
