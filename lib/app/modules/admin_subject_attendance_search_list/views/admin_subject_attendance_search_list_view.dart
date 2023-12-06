import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/set_attendance_tile/set_attendance_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../controllers/admin_subject_attendance_search_list_controller.dart';

class AdminSubjectAttendanceSearchListView
    extends GetView<AdminSubjectAttendanceSearchListController> {
  const AdminSubjectAttendanceSearchListView({super.key});

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
                  Obx(
                    () => controller.holidayLoader.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              controller.markHoliday.value =
                                  !controller.markHoliday.value;
                              controller.markUnMarkHoliday(
                                purpose: controller.markHoliday.value
                                    ? 'mark'
                                    : 'unmark',
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.primaryColor,
                              ),
                              child: Text(
                                controller.markHoliday.value
                                    ? "Unmark Holiday"
                                    : "Mark Holiday",
                                style: AppTextStyle.textStyle12WhiteW400,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              10.verticalSpacing,
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ))
                    : controller.adminStudentSubSearchList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  controller.adminStudentSubSearchList.length,
                              itemBuilder: (context, index) {
                                var data =
                                    controller.adminStudentSubSearchList[index];

                                return SetAttendanceTile(
                                  studentName: data.fullName,
                                  section: data.section,
                                  studentClass: data.className,
                                  imageUrl: data.studentPhoto,
                                  onPresentButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'P',
                                    );
                                  },
                                  onAbsentButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'A',
                                    );
                                  },
                                  onLateButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'L',
                                    );
                                  },
                                  onHalfDayButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'H',
                                    );
                                  },
                                  attendanceType: data.attendanceType ?? '',
                                );
                              },
                            ),
                          )
                        : const NoDataAvailableWidget(),
              ),
              30.verticalSpacing,
              Obx(
                () => controller.saveLoader.value
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                        text: "Save",
                        onTap: () {
                          controller.dataFilteringForApiCall();
                        },
                      ),
              ),
              30.verticalSpacing
            ],
          ),
        ),
      ),
    );
  }
}
