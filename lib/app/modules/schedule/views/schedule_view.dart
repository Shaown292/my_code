import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/modules/schedule/views/widget/schedule_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Schedule",
          body: RefreshIndicator(
            onRefresh: () async {},
            child: CustomBackground(
              customWidget: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: CustomDropdown(
                      dropdownValue: controller.recordDropdownValue.value,
                      scheduleList:
                          controller.homeController.studentRecordDropdownList,
                      changeDropdownValue: (v) {
                        controller.recordDropdownValue.value = v!;
                        controller.examinationController.examDropdownList.clear();
                        int recordId = controller.homeController.studentRecordIdList[controller.homeController.studentRecordDropdownList.indexOf(v)];
                        controller.examinationController.getStudentExamList(recordId: recordId);
                      },
                    ),
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: CustomDropdown(
                      dropdownValue: controller.dropdownValue.value,
                      scheduleList:
                      controller.examinationController.examDropdownList,
                      changeDropdownValue: (v) {
                        controller.dropdownValue.value = v!;
                        controller.scheduleList.clear();
                        int examId = controller.examinationController.examDropdownIdList[controller.examinationController.examDropdownList.indexOf(v)];
                        int recordId = controller.homeController.studentRecordList[0].id;
                        controller.getStudentExamScheduleList(
                          examId: examId, recordId: recordId,);
                      },
                    ),
                  ),

                  controller.loadingController.isLoading
                      ? const LoadingWidget()
                      : controller.scheduleList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: controller.scheduleList.length,
                                itemBuilder: (context, index) {
                                  return ScheduleDetailsTile(
                                    date: controller
                                        .scheduleList[index].dateAndDay,
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
        ));
  }
}
