import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/active_exam/views/widget/active_exam_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/active_exam_controller.dart';

class ActiveExamView extends GetView<ActiveExamController> {
  const ActiveExamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Active Exam",
          body: CustomBackground(
            customWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpacing,
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
                                  controller.onlineActiveExamList.clear();
                                  int recordId = controller.homeController
                                      .studentRecordList[index].id;
                                  controller.getStudentActiveExamList(
                                      recordId: recordId);
                                },
                                isSelected:
                                    controller.selectIndex.value == index,
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                controller.loadingController.isLoading
                    ? const LoadingWidget()
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            controller.onlineActiveExamList.clear();
                            controller.getStudentActiveExamList(
                                recordId: controller
                                    .homeController.studentRecordList[0].id);
                          },
                          child: controller.onlineActiveExamList.isNotEmpty
                              ? ListView.builder(
                                  itemCount:
                                      controller.onlineActiveExamList.length,
                                  itemBuilder: (context, index) {
                                    return ActiveExamTile(
                                      title: controller
                                          .onlineActiveExamList[index].title,
                                      subject: controller
                                          .onlineActiveExamList[index].subject,
                                      startingTime: controller
                                          .onlineActiveExamList[index]
                                          .startTime,
                                      endingTime: controller
                                          .onlineActiveExamList[index].endTime,
                                      activeStatus: controller
                                          .onlineActiveExamList[index].status,
                                      activeStatusColor: controller
                                                  .onlineActiveExamList[index]
                                                  .status ==
                                              'Closed'
                                          ? AppColors.homeworkStatusRedColor
                                          : AppColors.activeExamStatusBlueColor,
                                      color: index % 2 == 0
                                          ? Colors.white
                                          : AppColors.homeworkWidgetColor,
                                    );
                                  },
                                )
                              : const Center(child: NoDataAvailableWidget()),
                        ),
                      )
              ],
            ),
          ),
        ));
  }
}
