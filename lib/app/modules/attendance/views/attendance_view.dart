

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/attendance/views/widget/display_calender.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {

  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Attendance",
      body: SingleChildScrollView(
        child: CustomBackground(
          customWidget: Column(
            children: [
              DisplayCalender(
                eventList: controller.eventList,
              )
            ],
          ),
        ),
      ),
    );
  }
}
