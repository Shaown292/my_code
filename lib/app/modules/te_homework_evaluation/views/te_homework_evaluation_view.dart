import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/book_list/views/widget/search_field.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_evaluation_controller.dart';

class TeHomeworkEvaluationView extends GetView<TeHomeworkEvaluationController> {
  const TeHomeworkEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "${"Homework".tr} ${"Evaluation".tr}",
      body: CustomBackground(
        customWidget: Obx(
              () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
                child: SearchField(
                  borderRadius: 2,
                  controller: controller.searchController,
                  onChange: (searchKey) {},
                  hintTextStyle: AppTextStyle.fontSize12GreyW400,
                  icon: controller.searchController.text.isNotEmpty
                      ? InkWell(
                    onTap: () {
                      controller.searchController.clear();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.profileDividerColor,
                      size: 20,
                    ),
                  )
                      : Icon(
                    Icons.search,
                    color: AppColors.profileDividerColor,
                    size: 20,
                  ),
                ),
              ),
              5.verticalSpacing,
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: AppColors.profileCardBackgroundColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.19,
                      child: Text(
                        "Admission No".tr,
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      width: Get.width * 0.25,
                      child: Text(
                        "Student Name".tr,
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const SecondaryLoadingWidget()
                  : Expanded(
                child: controller.homeworksList.isNotEmpty
                    ? ListView.builder(
                    itemCount: controller.homeworksList.length,
                    itemBuilder: (context, index) {
                      return HomeworkTile(
                        widthOfFirstContainer: Get.width * 0.18,
                        widthOfSecondContainer: Get.width * 0.25,
                        onDownloadTap: () {
                          controller.downloadFile(
                              url: controller.homeworksList[index]
                                  .homeworkFiles!.first ??
                                  "",
                              title: controller.homeworksList[index]
                                  .homeworkFiles!.first ??
                                  "");
                        },
                        studentName: controller
                            .homeworksList[index].studentName,
                        admissionNo: controller
                            .homeworksList[index].admissionNo
                            .toString(),
                        downloadContainerColor: controller
                            .homeworksList[index]
                            .homeworkFiles!
                            .isEmpty
                            ? AppColors.transportDividerColor
                            : AppColors.syllabusTextColorBlack,
                        evaluateContainerColor:
                        controller.homeworksList[index].evaluated!
                            ? AppColors.appButtonColor
                            : AppColors.activeStatusGreenColor,
                        onEvaluationTap: () {
                          controller.evaluateStudent(
                              index: index,
                              studentId: controller
                                  .homeworksList[index].studentId!);
                        },
                        isEvaluation: true,
                      );
                    })
                    : const SingleChildScrollView(
                    child: Center(child: NoDataAvailableWidget())),
              ),
              10.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
