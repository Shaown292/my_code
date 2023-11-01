import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/result/views/widget/result_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/study_button/study_button.dart';
import 'package:get/get.dart';
import '../../../utilities/widgets/loader/loading.widget.dart';
import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Result",
          body: CustomBackground(
            customWidget: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () async {
                controller.examResultList.clear();
                controller.getStudentExamResultList(
                    examId: controller.currentExamId!,
                    recordId: controller.currentRecordId!);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpacing,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0),
                    child: SizedBox(
                      height: 50,
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
                                      print(controller.homeController
                                          .studentRecordList[index].id);
                                      controller.getStudentExamResultList(
                                          examId: controller
                                              .examinationController
                                              .examList[index]
                                              .id!,
                                          recordId: controller.homeController
                                              .studentRecordList[index].id);
                                    },
                                    isSelected:
                                    controller.selectIndex.value == index,
                                  ),
                                ));
                          }),
                    ),
                  ),
                  20.verticalSpacing,
                  controller.loadingController.isLoading
                      ? const LoadingWidget()
                      : controller.examResultList.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      itemCount: controller.examResultList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return ResultTile(
                          title: controller
                              .examResultList[index].examName,
                          subject: controller
                              .examResultList[index].subjectName,
                          totalMarks: controller
                              .examResultList[index].totalMarks,
                          obtainMarks: controller
                              .examResultList[index].obtainedMarks,
                          grade:
                          controller.examResultList[index].grade,
                          color: index % 2 == 0
                              ? AppColors.profileCardTextColor
                              : Colors.white,
                        );
                      },
                    ),
                  )
                      : const Center(
                    child: NoDataAvailableWidget(),
                  ),
                ],
              )
            ),
          ),
        ));
  }
}
