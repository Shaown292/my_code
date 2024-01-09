import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/staff_list/views/widget/staff_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/staff_list_controller.dart';

class StaffListView extends GetView<StaffListController> {
  const StaffListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "${controller.staffDesignation} List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            10.verticalSpacing,
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : controller.roleWiseStaffList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              controller.roleWiseStaffList.clear();
                              controller.getRoleWiseStaffList(
                                  staffRoleId: controller.staffId);
                            },
                            child: ListView.builder(
                              itemCount: controller.roleWiseStaffList.length,
                              itemBuilder: (context, index) {
                                return StaffTile(
                                  staffName: controller
                                      .roleWiseStaffList[index].firstName,
                                  staffAddress: controller
                                      .roleWiseStaffList[index].currentAddress,
                                  staffPhoneNo: controller
                                      .roleWiseStaffList[index].mobile,
                                  isImageEmpty: controller.roleWiseStaffList[index].staffPhoto.toString() == '' || controller.roleWiseStaffList[index].staffPhoto.toString().isEmpty ? true : false,
                                  imageUrl: controller.roleWiseStaffList[index].staffPhoto.toString(),
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.STAFF_INDIVIDUAL_DETAILS,
                                      arguments: {
                                        "staff_individual_id": controller
                                            .roleWiseStaffList[index].id,
                                        "staff_first_name" : controller.roleWiseStaffList[index].firstName,
                                        "staff_last_name" : controller.roleWiseStaffList[index].lastName,
                                        "staff_image" : controller.roleWiseStaffList[index].staffPhoto,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      : const NoDataAvailableWidget(
                          message: "No staff list available",
                        ),
            )
          ],
        ),
      ),
    );
  }
}
