import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_evaluation_controller.dart';

class TeHomeworkEvaluationView extends GetView<TeHomeworkEvaluationController> {
  const TeHomeworkEvaluationView({super.key});
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Homework Evaluation",
      body: CustomBackground(
        customWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeworkTile(
              subject: "Science",
              createDate: "1212",
              submissionDate: "212",
              evaluation: "N/A",
              marks: "52",
              isEvaluation: true,
            ),
            10.verticalSpacing,
            const Padding(
              padding: EdgeInsets.only(top: 5.0, left: 15),
              child: Text(
                "Student",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.transparent,
                  // Step 2 SEE HERE
                  shadows: [
                    Shadow(
                        offset: Offset(0, -5),
                        color: AppColors.syllabusTextColorBlack)
                  ],
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
