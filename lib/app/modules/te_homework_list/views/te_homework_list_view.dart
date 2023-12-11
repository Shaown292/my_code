import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_list_controller.dart';

class TeHomeworkListView extends GetView<TeHomeworkListController> {
  const TeHomeworkListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Homework List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Obx(
              () => controller.loadingController.isLoading
                  ? const Expanded(child: LoadingWidget())
                  : controller.teacherHomeworkList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: controller.teacherHomeworkList.length,
                            itemBuilder: (context, index) {
                              return HomeworkTile(
                                createDate: controller.teacherHomeworkList[index].creationDate,
                                submissionDate: controller.teacherHomeworkList[index].submissionDate,
                                evaluation: controller.teacherHomeworkList[index].evaluation,
                                marks: controller.teacherHomeworkList[index].marks.toString(),
                                subject: controller.teacherHomeworkList[index].subjectName,
                                onTap: () =>
                                    Get.toNamed(Routes.TE_HOMEWORK_EVALUATION),
                              );
                            },
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
