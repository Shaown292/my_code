import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_evaluation_controller.dart';

class TeHomeworkEvaluationView extends GetView<TeHomeworkEvaluationController> {
  const TeHomeworkEvaluationView({super.key});
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      title: "Homework Evaluation",
      body: CustomBackground(
        customWidget: Column(
          children: [
            HomeworkTile(
              subject: "Science",
              createDate: "1212",
              submissionDate: "212",
              evaluation: "N/A",
              marks: "52",
            )
          ],
        ),
      ),
    );
  }
}
