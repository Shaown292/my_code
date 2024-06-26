import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
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
      title: "Set Attendance".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.attendanceStudentData.students == null ||
                  controller.attendanceStudentData.students!.isEmpty
              ? const NoDataAvailableWidget()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.58,
                          child: Text(
                              "Student Attendance not done yet.\nSelect Present/Absent/Late/Half Day"
                                  .tr),
                        ),
                        5.horizontalSpacing,
                        Obx(
                          () => controller.holidayLoader.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : InkWell(
                                  onTap: () {
                                    controller.markUnMarkHoliday();

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Text(
                                      controller.markHoliday.value
                                          ? "Unmarked Holiday".tr
                                          : "Mark Holiday".tr,
                                      style: AppTextStyle.textStyle12WhiteW400,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    10.verticalSpacing,
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount:
                              controller.adminClassSetAttendanceList.length,
                          itemBuilder: (context, index) {
                            var data =
                                controller.adminClassSetAttendanceList[index];

                            return SetAttendanceTile(
                              studentName: controller.attendanceStudentData
                                  .students![index].fullName,
                              section:
                                  controller.attendanceStudentData.sectionName,
                              studentClass:
                                  controller.attendanceStudentData.className,
                              imageUrl: "${controller
                                  .adminClassSetAttendanceList[index]
                                  .studentPhoto}",
                              isImageEmpty: false,
                              onPresentButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'P',
                                );
                              },
                              onAbsentButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'A',
                                );
                              },
                              onLateButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'L',
                                );
                              },
                              onHalfDayButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'H',
                                );
                              },
                              onAddNoteTap: () {
                                controller.noteTextController.text = controller
                                        .adminClassSetAttendanceList[index]
                                        .note ??
                                    '';
                                controller.showAddNoteBottomSheet(
                                    index: index, color: Colors.white);
                              },
                              attendanceType: data.attendanceType ?? '',
                            );
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.saveLoader.value
                          ? const SecondaryLoadingWidget(
                              isBottomNav: true,
                            )
                          : Container(
                              height: Get.height * 0.1,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: PrimaryButton(
                                text: "Save".tr,
                                onTap: () {
                                  controller.dataFiltering();
                                },
                              ),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
