import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_lesson_plan_response_model/student_lesson_plan_response_model.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/show_week_tile/show_week_tile.dart';
import '../../../utilities/widgets/student_class_details_card/student_calss_details_card.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/student_lesson_plan_controller.dart';

class StudentLessonPlanView extends GetView<StudentLessonPlanController> {
  const StudentLessonPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      initialIndex: controller.selectTabIndex.value,
      length: controller.daysOfWeek.length,
      child: InfixEduScaffold(
        title: "Lesson Plan",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: controller.loadingController.isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
                : Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller
                        .homeController.studentRecordList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 8, bottom: 8),
                        child: StudyButton(
                          title:
                          "Class ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                          onItemTap: () {
                            controller.weeksList.clear();
                            int recordId = controller.homeController
                                .studentRecordList[index].id;
                            controller.getLessonPlanList(
                                GlobalVariableController.userId!,
                                recordId);
                            controller.selectIndex.value = index;
                          },
                          isSelected:
                          controller.selectIndex.value == index,
                        ),
                      );
                    },
                  ),
                ),
                20.verticalSpacing,
                Text(
                  controller.formattedDate,
                  style: AppTextStyle.fontSize14VioletW600,
                ),
                20.verticalSpacing,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.profileCardTextColor),
                  ),
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    controller: controller.tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.appButtonColor),
                    tabs: List.generate(
                      controller.daysOfWeek.length,
                          (index) => ShowWeekTile(
                        title: controller.daysOfWeek[index],
                      ),
                    ),
                  ),
                ),
                10.verticalSpacing,
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: List.generate(
                      controller.daysOfWeek.length,
                          (index) {
                        return Obx(() => controller
                            .loadingController.isLoading
                            ? const LoadingWidget()
                            : controller.weeksList[index].classRoutine!
                            .isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller
                              .weeksList[index]
                              .classRoutine!
                              .length,
                          itemBuilder:
                              (context, routineIndex) {
                            ClassRoutine classRoutine =
                            controller.weeksList[index]
                                .classRoutine![
                            routineIndex];
                            return StudentClassDetailsCard(
                              subject:
                              classRoutine.subjectName,
                              startingTime:
                              classRoutine.startTime,
                              endingTime:
                              classRoutine.endTime,
                              roomNumber: classRoutine.room,
                              buildingName: "Building No",
                              instructorName:
                              classRoutine.teacher,
                              onDetailsButtonTap: controller.onDetailsButtonTapped,
                              hasDetails: true,
                              onTap: () {
                                controller.onDetailsButtonTapped = true;
                                controller
                                    .showLessonPlanDetailsBottomSheet(
                                    index: index);
                              }
                            );
                          },
                        )
                            : const NoDataAvailableWidget());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
