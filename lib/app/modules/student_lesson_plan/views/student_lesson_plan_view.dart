import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

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
    return DefaultTabController(
      length: controller.daysOfWeek.length,
      child: InfixEduScaffold(
        title: "Lesson Plan",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          controller.homeController.studentRecordList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => StudyButton(
                              title:
                                  "Class ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                              onItemTap: () {
                                controller.selectIndex.value = index;
                              },
                              isSelected: controller.selectIndex.value == index,
                            ),
                          ),
                        );
                      },
                    ),
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
                    border: Border.all(color: AppColors.profileCardTextColor),
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
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return StudentClassDetailsCard(
                              subject: "Bangle 1st Paper",
                              startingTime: "3:50 AM",
                              endingTime: "3:50 AM",
                              roomNumber: "103",
                              buildingName: 'Building Name',
                              instructorName: "Teacher Three",
                              hasDetails: true,
                              onTap: () =>
                                  controller.showLessonPlanDetailsBottomSheet(
                                      index: index),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
