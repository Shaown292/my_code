

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../utilities/app_functions/functionality.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {

  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Attendance'.tr,

      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.attendanceTileList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Obx(() => CustomCardTile(
                  icon: controller.attendanceTileList[index].icon,
                  title: controller.attendanceTileList[index].title.tr,
                  onTap: () {
                    controller.selectIndex.value = index;
                    AppFunctions.getStudentDashboardNavigation(title: controller.attendanceTileList[index].value);
                  },
                  isSelected: controller.selectIndex.value == index,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
