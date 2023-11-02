import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/exam_result/views/widget/exam_result_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/exam_result_controller.dart';

class ExamResultView extends GetView<ExamResultController> {
  const ExamResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Exam Result",
          body: CustomBackground(
              customWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpacing,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                controller.onlineExamResultList.clear();
                                // int recordId = controller.homeController
                                //     .studentRecordList[index].id;
                                controller.getStudentExamResultList(
                                    studentId: GlobalVariableController.studentId!);
                              },
                              isSelected:
                              controller.selectIndex.value == index,
                            ),
                          ));
                    },
                  ),
                ),
              ),
              20.verticalSpacing,
              controller.loadingController.isLoading
                  ? const LoadingWidget()
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.onlineExamResultList.clear();
                          controller.getStudentExamResultList(studentId: GlobalVariableController.studentId!);
                        },
                        child: controller.onlineExamResultList.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    controller.onlineExamResultList.length,
                                itemBuilder: (context, index) {
                                  return ExamResultTile(
                                    title: controller.onlineExamResultList[index].title,
                                    startingTime: controller.onlineExamResultList[index].examTime,
                                    endingTime: controller.onlineExamResultList[index].examTime,
                                    result: controller.onlineExamResultList[index].result,
                                    activeStatusColor: controller.onlineExamResultList[index].result == 'Fail' ? AppColors.homeworkStatusRedColor : AppColors.homeworkStatusGreenColor,
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : AppColors.homeworkWidgetColor,
                                  );
                                },
                              )
                            : const Center(child: NoDataAvailableWidget()),
                      ),
                    ),
            ],
          )),
        ));
  }
}
