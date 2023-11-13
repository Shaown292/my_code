

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/attendance/views/widget/display_calender.dart';
import 'package:flutter_single_getx_api_v2/app/modules/attendance/views/widget/event_status.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {

  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Attendance",
      body: Obx(() => CustomBackground(
        customWidget: SingleChildScrollView(
          child: controller.loadingController.isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)) :  Column(
            children: [
              DisplayCalender(
                eventList: controller.eventList,
                onCalendarChange: (DateTime date){
                  print(':::::::::::: $date');
                  controller.getAttendanceList(recordId: controller.homeController.studentRecordList[0].id, studentId: GlobalVariableController.studentId!);

                },
              ),

              EventStatus(
                color: const Color(0xFF00C106),
                title: "Present",
                numberOfDays: controller.present.value,
              ),
              EventStatus(
                color: const Color(0xFF5057FC),
                title: "Halfday",
                numberOfDays: controller.halfDay.value,
              ),
              EventStatus(
                color: const Color(0xFFFF6F00),
                title: "Late",
                numberOfDays: controller.late.value,
              ),
              EventStatus(
                color: const Color(0xFFF32E21),
                title: "Absent",
                numberOfDays: controller.absent.value,
              ),
              EventStatus(
                color: const Color(0xFF462564),
                title: "Holiday",
                numberOfDays: controller.holiday.value,
              ),

            ],
          ),
        ),
      )),
    );
  }
}
