import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_vehicle_controller.dart';
import 'widget/vehicle_tile.dart';

class AdminVehicleView extends GetView<AdminVehicleController> {
  const AdminVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Obx(
        () => InfixEduScaffold(
          title: "Add Vehicle".tr,
          body: SingleChildScrollView(
            child: CustomBackground(
              customWidget: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TabBar(
                      labelColor: AppColors.profileValueColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle:
                          AppTextStyle.fontSize12LightGreyW500,
                      indicatorColor: AppColors.profileIndicatorColor,
                      controller: controller.tabController,
                      tabs: List.generate(
                        controller.tabs.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            controller.tabs[index],
                          ),
                        ),
                      ),
                      onTap: (index){
                        controller.tabIndex.value = index;
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        /// Add Vehicle
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                controller: controller.vehicleNoTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "Vehicle No".tr,
                                hintTextStyle:
                                    AppTextStyle.fontSize14lightBlackW400,
                                fillColor: Colors.white,
                              ),
                              10.verticalSpacing,
                              CustomTextFormField(
                                controller:
                                    controller.vehicleModelTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "Vehicle Model".tr,
                                hintTextStyle:
                                    AppTextStyle.fontSize14lightBlackW400,
                                fillColor: Colors.white,
                              ),
                              10.verticalSpacing,
                              CustomTextFormField(
                                controller: controller.madeYearTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "Made Year".tr,
                                hintTextStyle:
                                    AppTextStyle.fontSize14lightBlackW400,
                                fillColor: Colors.white,
                              ),
                              10.verticalSpacing,

                               Text(
                                "Add Driver Name*".tr,
                                style: AppTextStyle.fontSize13BlackW400,
                              ),
                              5.verticalSpacing,

                              /// Driver list dropdown
                              controller.dropdownLoader.value
                                  ? const SecondaryLoadingWidget()
                                  : DuplicateDropdown(
                                      dropdownValue:
                                          controller.initialValue.value,
                                      dropdownList:
                                          controller.adminVehicleDriverList,
                                      changeDropdownValue: (value) {
                                        controller.initialValue.value = value!;
                                        controller.driverId.value = value.id;
                                      },
                                    ),
                              10.verticalSpacing,
                              CustomTextFormField(
                                controller: controller.noteTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "Note".tr,
                                hintTextStyle:
                                    AppTextStyle.fontSize14lightBlackW400,
                                fillColor: Colors.white,
                              ),
                              (Get.height * 0.25).verticalSpacing,
                              controller.saveLoader.value
                                  ? const SecondaryLoadingWidget(
                                isBottomNav: true,
                              )
                                  : PrimaryButton(
                                text: "Save".tr,
                                onTap: () {
                                  if (controller.validation()) {
                                    controller.addAdminVehicle();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        /// Vehicle List
                        Obx(
                          () => controller.loadingController.isLoading
                              ? const SecondaryLoadingWidget()
                              : controller.adminVehicleList.isNotEmpty
                                  ? RefreshIndicator(
                                      onRefresh: () async {
                                        controller.getAdminVehicleList();
                                      },
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.adminVehicleList.length,
                                        itemBuilder: (context, index) {
                                          return VehicleTile(
                                            model: controller
                                                .adminVehicleList[index]
                                                .vehicleModel,
                                            number: controller
                                                .adminVehicleList[index]
                                                .vehicleNo,
                                            madeYear: controller
                                                .adminVehicleList[index]
                                                .madeYear
                                                .toString(),
                                            note: controller
                                                .adminVehicleList[index].note,
                                            color: index % 2 == 0
                                                ? AppColors.profileCardTextColor
                                                : Colors.white,
                                          );
                                        },
                                      ),
                                    )
                                  : const NoDataAvailableWidget(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
