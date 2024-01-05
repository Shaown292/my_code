import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_homework/views/widgets/homework_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';

import '../../../../domain/utils/datetime_converter.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../controllers/student_homework_controller.dart';

class StudentHomeworkView extends GetView<StudentHomeworkController> {
  const StudentHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Homework".tr,
          body: RefreshIndicator(
            onRefresh: () async {
              controller.studentHomeworkList.clear();
              controller.getHomeWorkList();
            },
            child: CustomBackground(
              customWidget: controller.loadingController.isLoading
                  ? const LoadingWidget()
                  : controller.studentHomeworkList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.studentHomeworkList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = controller.studentHomeworkList[index];
                            String createdAt = DateTimeConverter()
                                .convertISOToDesiredFormat(
                                    data.createdAt ?? '');
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: HomeworkCardTile(
                                subject: data.subject,
                                created: createdAt,
                                submission: data.submissionDate,
                                evaluation: data.evaluationDate,
                                status: data.status,
                                marks: data.marks.toString(),
                                statusColor: data.status == 'Completed'
                                    ? AppColors.homeworkStatusGreenColor
                                    : AppColors.homeworkStatusRedColor,
                                backgroundColor: index % 2 == 0
                                    ? Colors.white
                                    : AppColors.homeworkWidgetColor,
                                onTap: () {
                                  controller.showHomeworkDetailsBottomSheet(
                                    index: index,
                                    color: Colors.white,
                                    onDownloadTap: () {
                                      if (controller.studentHomeworkList[index]
                                                  .file ==
                                              null ||
                                          controller.studentHomeworkList[index]
                                                  .file ==
                                              '') {
                                        showBasicFailedSnackBar(
                                            message:
                                                'No file available on server');
                                      } else {
                                        controller.downloadFile(
                                            url: controller
                                                .studentHomeworkList[index]
                                                .file!,
                                            title: controller
                                                    .studentHomeworkList[index]
                                                    .subject ??
                                                '');
                                      }
                                    },
                                    onUploadTap: () => controller.isUpload.value = true,
                                    onTapBrowse: () => controller.pickFile(),
                                    onTapForSave: (){
                                      controller.uploadFilesWithId(controller.pickedFileList, controller.studentHomeworkList[index].id!);
                                    },

                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const NoDataAvailableWidget(),
            ),
          ),
        ));
  }
}
