import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/modules/schedule/views/widget/schedule_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/study_button/study_button.dart';
import 'package:get/get.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Schedule",
        body: RefreshIndicator(
          onRefresh: () async {},
          child: CustomBackground(
            customWidget: Column(
              children: [
                controller.examinationController.loadingController.isLoading
                    ? const SizedBox(
                        height: 55,
                        child: LoadingWidget(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 0),
                        child: SizedBox(
                          height: 55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .homeController.studentRecordList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(
                                  () => StudyButton(
                                    title:
                                        "Class ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                                    onItemTap: () {
                                      controller.selectIndex.value = index;
                                      controller.examinationController
                                          .examDropdownList
                                          .clear();
                                      int recordId = controller.homeController
                                          .studentRecordList[index].id;
                                      controller.examinationController
                                          .getStudentExamList(
                                              recordId: recordId);
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
                controller.examinationController.loadingController.isLoading
                    ? const CustomisedLoadingWidget()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: DuplicateDropdown(
                          dropdownValue: controller
                              .examinationController.dropdownValue.value,
                          dropdownList:
                              controller.examinationController.dropdownList,
                          changeDropdownValue: (v) {
                            controller
                                .examinationController.dropdownValue.value = v!;
                            controller.scheduleList.clear();
                            int examId = v.id;
                            int recordId = controller
                                .homeController.studentRecordList[0].id;
                            controller.getStudentExamScheduleList(
                              examId: examId,
                              recordId: recordId,
                            );
                          },
                        ),
                      ),
                controller.loadingController.isLoading
                    ? const Expanded(
                        child: LoadingWidget(),
                      )
                    : controller.scheduleList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: controller.scheduleList.length,
                              itemBuilder: (context, index) {
                                return ScheduleDetailsTile(
                                  date:
                                      controller.scheduleList[index].dateAndDay,
                                  subject:
                                      controller.scheduleList[index].subject,
                                  time: controller.scheduleList[index].time,
                                  roomNo: controller.scheduleList[index].room,
                                  section: controller
                                      .scheduleList[index].classSection,
                                  teacher:
                                      controller.scheduleList[index].teacher,
                                  color: index % 2 == 0
                                      ? AppColors.profileCardTextColor
                                      : Colors.white,
                                );
                              },
                            ),
                          )
                        : const NoDataAvailableWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
