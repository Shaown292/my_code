import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_homework/views/widgets/homework_card_tile.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../../domain/utils/datetime_converter.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../controllers/student_homework_controller.dart';

class StudentHomeworkView extends GetView<StudentHomeworkController> {
  const StudentHomeworkView({Key? key}) : super(key: key);
  // controller.loadingController.isLoading == false ? const Center(child: CircularProgressIndicator()) :
  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
      title: "Homework",
      body: RefreshIndicator(
        onRefresh: () async {
          controller.studentHomeworkList.clear();
          controller.getHomeWorkList();
        },
        child: CustomBackground(
            customWidget: controller.loadingController.isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: controller.studentHomeworkList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = controller.studentHomeworkList[index];
                String createdAt = DateTimeConverter().convertISOToDesiredFormat(data.createdAt ?? '');
                return Column(
                  children: [
                    Padding(
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
                        backgroundColor:
                        index % 2 == 0 ? Colors.white : AppColors.homeworkWidgetColor,
                        onTap: (){
                          controller.showHomeworkDetailsBottomSheet(index: index);
                        },
                      ),
                    ),
                  ],
                );
              },
            )
        ),
      ),
    ));
  }

}
