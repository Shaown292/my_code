import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/dummy_data/schedule/schedule_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/modules/schedule/views/widget/schedule_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Schedule",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Obx(
                () => CustomDropdown(
                  dropdownValue: controller.dropdownValue.value,
                  scheduleList: controller.dropdownList,
                  changeDropdownValue: (v) {
                    controller.dropdownValue.value = v!;
                  },
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: scheduleData.length,
                    itemBuilder: (context, index) {
                      return ScheduleDetailsTile(
                        date: scheduleData[index].date,
                        subject: scheduleData[index].subject,
                        time: scheduleData[index].time,
                        roomNo: scheduleData[index].roomNo,
                        section: scheduleData[index].section,
                        teacher: scheduleData[index].teacher,
                        color: index % 2 == 0
                            ? Colors.white
                            : AppColors.profileCardTextColor,
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
