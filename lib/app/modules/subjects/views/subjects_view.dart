import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/subjects/views/widget/subject_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../controllers/subjects_controller.dart';

class SubjectsView extends GetView<SubjectsController> {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Subjects",
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
            Obx(
              () => controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : controller.subjectList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            color: AppColors.primaryColor,
                            onRefresh: () async {
                              controller.subjectList.clear();
                              controller.getAllSubjectList(
                                  recordId: controller
                                      .homeController.studentRecordIdList[0]);
                            },
                            child: ListView.builder(
                              itemCount: controller.subjectList.length,
                              itemBuilder: (context, index) {
                                return SubjectTile(
                                  subject:
                                      controller.subjectList[index].subject,
                                  teacher:
                                      controller.subjectList[index].teacher,
                                  lectureType:
                                      controller.subjectList[index].type,
                                );
                              },
                            ),
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
