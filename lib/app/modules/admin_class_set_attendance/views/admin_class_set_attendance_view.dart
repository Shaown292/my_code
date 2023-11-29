import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/set_attendance_tile/set_attendance_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_set_attendance_controller.dart';

class AdminClassSetAttendanceView
    extends GetView<AdminClassSetAttendanceController> {
  const AdminClassSetAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Set Attendance",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      "Student Attendance not done yet.\nSelect Present/Absent/Late/Half Day"),
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: const Text(
                        "Mark Holiday",
                        style: AppTextStyle.textStyle12WhiteW400,
                      ),
                    ),
                  )
                ],
              ),
              10.verticalSpacing,
              Obx(() => Expanded(
                child: controller.attendanceStudentList.students!.isNotEmpty ? controller.isLoading.value ? const LoadingWidget() : ListView.builder(
                  itemCount: controller.attendanceStudentList.students!.length,
                  itemBuilder: (context, index) {
                    return SetAttendanceTile(
                      studentName: controller.attendanceStudentList.students![index].fullName,
                      section: controller.attendanceStudentList.sectionName,
                      studentClass: controller.attendanceStudentList.className,
                      onPresentButtonTap: () {
                        controller.status.value = "P";
                        controller.selectIndex.value = index;
                      },
                      onAbsentButtonTap: () {
                        controller.status.value = "A";
                        controller.selectIndex.value = index;
                      },
                      onLateButtonTap: () {
                        controller.status.value = "L";
                      },
                      onHalfDayButtonTap: () {
                        controller.status.value = "H";
                      },
                      status: controller.status.value,
                      isSelected: controller.selectIndex.value == index,
                    );
                  },
                ) : const NoDataAvailableWidget(),
              ),),
              30.verticalSpacing,
              PrimaryButton(
                text: "Save",
                onTap: () {},
              ),
              30.verticalSpacing
            ],
          ),
        ),
      ),
    );
  }
}
