import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
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
          title: "Add Vehicle",
          body: RefreshIndicator(
            onRefresh: () async {
            },
            color: AppColors.primaryColor,
            child: SingleChildScrollView(
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
                        unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
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
                              children: [


                                CustomTextFormField(
                                  controller: controller.vehicleNoTextController,
                                  enableBorderActive: true,
                                  focusBorderActive: true,
                                  hintText: "Vehicle No",
                                  hintTextStyle:
                                      AppTextStyle.fontSize14lightBlackW400,
                                  fillColor: Colors.white,
                                ),
                                10.verticalSpacing,
                                CustomTextFormField(
                                  controller: controller.vehicleModelTextController,
                                  enableBorderActive: true,
                                  focusBorderActive: true,
                                  hintText: "Vehicle Model",
                                  hintTextStyle:
                                      AppTextStyle.fontSize14lightBlackW400,
                                  fillColor: Colors.white,
                                ),
                                10.verticalSpacing,
                                CustomTextFormField(
                                  controller: controller.madeYearTextController,
                                  enableBorderActive: true,
                                  focusBorderActive: true,
                                  hintText: "Made Year",
                                  hintTextStyle:
                                      AppTextStyle.fontSize14lightBlackW400,
                                  fillColor: Colors.white,
                                ),
                                10.verticalSpacing,
                                /// Driver list dropdown
                                CustomDropdown(
                                  dropdownValue: controller.initialValue.value,
                                  dropdownList: controller.list,
                                  changeDropdownValue: (value) {
                                    controller.initialValue.value = value!;
                                  },
                                ),
                                10.verticalSpacing,
                                CustomTextFormField(
                                  controller: controller.noteTextController,
                                  enableBorderActive: true,
                                  focusBorderActive: true,
                                  hintText: "Note",
                                  hintTextStyle:
                                      AppTextStyle.fontSize14lightBlackW400,
                                  fillColor: Colors.white,
                                ),
                                30.verticalSpacing,
                                PrimaryButton(
                                  text: "Save",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),

                          /// Vehicle List
                          ListView.builder(
                            shrinkWrap: true,

                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return  VehicleTile(
                                model: "Infix 101",
                                number: "21212",
                                madeYear: "2023",
                                note: "Note",
                                color:  index % 2 == 0
                              ? AppColors.profileCardTextColor
                                  : Colors.white,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
