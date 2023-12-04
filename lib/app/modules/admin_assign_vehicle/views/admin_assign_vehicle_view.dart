import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/admin_assign_vehicle_controller.dart';

class AdminAssignVehicleView extends GetView<AdminAssignVehicleController> {
  const AdminAssignVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Assign Vehicle To Route",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Route",
                style: AppTextStyle.fontSize16lightBlackW500,
              ),
              10.verticalSpacing,
              CustomDropdown(
                dropdownValue: controller.initialValue.value,
                dropdownList: controller.list,
                changeDropdownValue: (value) {
                  controller.initialValue.value = value!;
                },
              ),
              20.verticalSpacing,
              const Text(
                "Select Vehicle",
                style: AppTextStyle.fontSize16lightBlackW500,
              ),10.verticalSpacing,
              CustomDropdown(
                dropdownValue: controller.initialValue.value,
                dropdownList: controller.list,
                changeDropdownValue: (value) {
                  controller.initialValue.value = value!;
                },
              ),
              50.verticalSpacing,
              PrimaryButton(
                text: "Save",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}