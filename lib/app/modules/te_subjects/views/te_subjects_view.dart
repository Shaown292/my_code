import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/subjects/views/widget/subject_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_subjects_controller.dart';

class TeSubjectsView extends GetView<TeSubjectsController> {
  const TeSubjectsView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Subject",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(15),
                height: Get.height * 0.07,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: AppColors.profileCardTextColor),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.25,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Subject",
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                    5.horizontalSpacing,
                    SizedBox(
                      width: Get.width * 0.25,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Teacher",
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                    5.horizontalSpacing,
                    SizedBox(
                      width: Get.width * 0.25,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Type",
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpacing,
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return const SubjectTile(
                    subject: "Subject",
                    teacher: "TeacherTeacherTeacherTeacherTeacherTeacher" ,
                    lectureType: "Practical",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
