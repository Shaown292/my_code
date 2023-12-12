import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_search_attendance/views/widget/display_calender.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_search_attendance/views/widget/event_status.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/study_button/study_button.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_details_controller.dart';

class AdminSubjectAttendanceSearchIndividualDetailsView
    extends GetView<AdminSubjectAttendanceSearchIndividualDetailsController> {
  const AdminSubjectAttendanceSearchIndividualDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Attendance",
      body: Obx(() => CustomBackground(
            customWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => StudyButton(
                                title: "Five (Rose)",
                                onItemTap: () {
                                  controller.selectIndex.value = index;
                                },
                                isSelected:
                                    controller.selectIndex.value == index,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DisplayCalender(
                          currentDate: controller.currentDate,
                          eventList: controller.eventList,
                          onCalendarChanged: (DateTime date) {
                            controller
                                .getAdminAttendanceSubDetailsListWithDate(
                                  recordId: controller.recordId.value,
                                  subjectNameId: controller.subjectNameId.value,
                                  month: date.month,
                                  year: date.year,
                                )
                                .then((value) => controller.setEventData());
                          },
                        ),
                  EventStatus(
                    color: const Color(0xFF00C106),
                    title: "Present",
                    numberOfDays: controller.present.value,
                  ),
                  EventStatus(
                    color: const Color(0xFF5057FC),
                    title: "Half day",
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
