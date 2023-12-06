import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
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
              Obx(
                () => controller.dropdownLoader.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : DuplicateDropdown(
                        dropdownValue: controller.assignRouteInitialValue.value,
                        dropdownList: controller.assignRouteList,
                        changeDropdownValue: (value) {
                          controller.assignRouteInitialValue.value = value!;
                          controller.routeId.value = value.id;
                        },
                      ),
              ),
              20.verticalSpacing,
              const Text(
                "Select Vehicle",
                style: AppTextStyle.fontSize16lightBlackW500,
              ),
              10.verticalSpacing,
              Obx(
                () => controller.dropdownLoader.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : DuplicateDropdown(
                        dropdownValue: controller.assignVehicleInitialValue.value,
                        dropdownList: controller.assignVehicleList,
                        changeDropdownValue: (value) {
                          controller.assignVehicleInitialValue.value = value!;
                          controller.vehicleId.value = value.id;
                        },
                      ),
              ),
              50.verticalSpacing,
              Obx(
                () => controller.loadingController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ))
                    : PrimaryButton(
                        text: "Save",
                        onTap: () {
                          if (controller.assignRouteList.isNotEmpty &&
                              controller.assignVehicleList.isNotEmpty) {
                            controller.addAssignVehicleToRoute(
                              routeId: controller.routeId.value,
                              vehicleId: controller.vehicleId.value,
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
