import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_search_subject_attendance/views/widgets/search_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_search_subject_attendance/views/widgets/subject_card_title.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/student_search_subject_attendance_controller.dart';

class StudentSearchSubjectAttendanceView
    extends GetView<StudentSearchSubjectAttendanceController> {
  const StudentSearchSubjectAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Select Subject",
        body: CustomBackground(
          customWidget: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        controller.homeController.studentRecordList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StudyButton(
                          title:
                              "Class ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                          onItemTap: () {
                            controller.selectIndex.value = index;
                            controller.recordId.value = controller
                                .homeController.studentRecordList[index].id;

                            controller.subjectsController.getAllSubjectList(
                                recordId: controller.recordId.toInt());
                          },
                          isSelected: controller.selectIndex.value == index,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: Get.height * 0.06,
                  color: AppColors.profileCardTextColor,
                  child: Row(
                    children: [
                      const SubjectCardTitle(
                        title: 'Subject',
                      ),
                      5.horizontalSpacing,
                      const SubjectCardTitle(
                        title: 'Teacher',
                      ),
                      5.horizontalSpacing,
                      const SubjectCardTitle(
                        title: 'Type',
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpacing,
              controller.subjectsController.loadingController.isLoading
                  ? const CustomisedLoadingWidget()
                  : controller.subjectsController.subjectList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              controller.subjectsController.getAllSubjectList(
                                recordId: controller.recordId.toInt(),
                              );
                            },
                            child: ListView.builder(
                              itemCount: controller
                                  .subjectsController.subjectList.length,
                              itemBuilder: (context, index) {
                                return SearchDetailsTile(
                                  subject: controller.subjectsController
                                      .subjectList[index].subject,
                                  teacher: controller.subjectsController
                                      .subjectList[index].teacher,
                                  lectureType: controller.subjectsController
                                      .subjectList[index].type,
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.STUDENT_SEARCH_ATTENDANCE,
                                      arguments: {
                                        "subjectID": controller
                                            .subjectsController
                                            .subjectList[index]
                                            .id,
                                        "from": true
                                      },

                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
