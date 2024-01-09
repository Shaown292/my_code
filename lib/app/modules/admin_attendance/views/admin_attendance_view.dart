import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_attendance_controller.dart';

class AdminAttendanceView extends GetView<AdminAttendanceController> {
  const AdminAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        leadingIcon: controller.globalRxVariableController.roleId.value == 1
            ? InkWell(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  height: 50,
                  width: 50,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )
            : const SizedBox(),
        title: "Attendance".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.adminAttendanceTileList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Obx(() => CustomCardTile(
                        icon: controller.adminAttendanceTileList[index].icon,
                        title:
                            controller.adminAttendanceTileList[index].title.tr,
                        iconColor: AppColors.primaryColor.withOpacity(0.7),
                        onTap: () {
                          controller.selectIndex.value = index;
                          AppFunctions.getAdminHomeNavigation(
                              title: controller
                                  .adminAttendanceTileList[index].value);
                        },
                        isSelected: controller.selectIndex.value == index,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
