import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/study_button/study_button.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_homework_model/te_homework_evaluation_list_response_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TeHomeworkEvaluationController extends GetxController {
  TextEditingController addMarksController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxInt clasId = 0.obs;
  RxString clasName = "".obs;
  RxString sectionName = "".obs;
  RxString commentStatus = "G".obs;
  RxString homeworkStatus = "C".obs;
  RxBool submitEvaluationLoader = false.obs;
  RxInt sectionId = 0.obs;
  RxInt homeworkId = 0.obs;
  RxInt studentId = 0.obs;
  final subjectName = Rxn<String>();
  final assignDate = Rxn<String>();
  final submissionDate = Rxn<String>();
  final evaluation = Rxn<String>();
  final file = Rxn<String>();
  final marks = Rxn<int>();
  final selectIndex = RxInt(0);
  final selectIndexForHomework = RxInt(0);

  List<String> commentStatusList = ["Good", "Not Good"];
  List<String> homeworkStatusList = ["Completed", "Not Completed"];



  RxList<HomeworkList> homeworkEvaluationList = <HomeworkList>[].obs;

  RxBool isLoading = false.obs;

  Future<TeHomeworkEvaluationListResponseModel>
  getHomeworkEvaluationList(String searchKey) async {
    try {
      homeworkEvaluationList.clear();
      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherHomeworkEvaluationList(
          classId: clasId.value,
          sectionId: sectionId.value,
          homeworkId: homeworkId.value,
          searchKey: searchKey,

        ),
        header: GlobalVariable.header,
      );

      TeHomeworkEvaluationListResponseModel
      teHomeworkEvaluationListResponseModel =
      TeHomeworkEvaluationListResponseModel.fromJson(response);

      if (teHomeworkEvaluationListResponseModel.success == true) {
        isLoading.value = false;
        if (teHomeworkEvaluationListResponseModel.data!.isNotEmpty) {
          for (var element
          in teHomeworkEvaluationListResponseModel.data!) {
            homeworkEvaluationList.add(element);
          }
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
            message: teHomeworkEvaluationListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return TeHomeworkEvaluationListResponseModel();
  }

  void evaluateStudent({required int index, required int studentId}) {
    Get.dialog(
      Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpacing,
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      20.horizontalSpacing,
                      const Text(
                        "Evaluate",
                        style: AppTextStyle.fontSize13BlackW400,
                      ),
                    ],
                  ),
                  30.verticalSpacing,
                  CustomTextFormField(
                    controller: addMarksController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Add Marks".tr} *",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  20.verticalSpacing,
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Comment",
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: commentStatusList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Obx(
                                () => StudyButton(
                              title: commentStatusList[index],
                              onItemTap: () {
                                selectIndex.value = index;
                                selectIndex.value == 0 ? commentStatus.value == "G" : commentStatus.value = "NG";
                              },
                              isSelected: selectIndex.value == index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  20.verticalSpacing,
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Homework Status",
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeworkStatusList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Obx(
                                () => StudyButton(
                              title: homeworkStatusList[index],
                              onItemTap: () {
                                selectIndexForHomework.value = index;
                                selectIndex.value == 0 ? homeworkStatus.value == "C" : homeworkStatus.value = "NC";
                              },
                              isSelected: selectIndexForHomework.value == index,

                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  100.verticalSpacing,
                  submitEvaluationLoader.value
                      ? const SecondaryLoadingWidget()
                      : PrimaryButton(
                    text: "Evaluate".tr,
                    onTap: () {
                      if (addMarksController.text.isNotEmpty) {
                        submitEvaluation(
                          studentId: studentId,
                          homeworkStatus: homeworkStatus.value,
                          commentStatus: commentStatus.value,
                          index: index,
                        );
                      } else {
                        showBasicFailedSnackBar(message: "Add Marks");
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitEvaluation({
    required int studentId,
    required String commentStatus,
    required String homeworkStatus,
    required int index,
  }) async {
    try {
      submitEvaluationLoader.value = true;
      addMarksController.clear();
      final response = await BaseClient().postData(
        url: InfixApi.submitEvaluation,
        header: GlobalVariable.header,
        payload: {
          "student_id": studentId,
          "homework_id": homeworkId.value,
          "marks": addMarksController.text,
          "homework_status": homeworkStatus,
          "teacher_comments": commentStatus,
        },
      );

      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        homeworkEvaluationList[index].evaluated = true;
        homeworkEvaluationList.refresh();
        submitEvaluationLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? "Successful");
      } else {
        submitEvaluationLoader.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      submitEvaluationLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      submitEvaluationLoader.value = false;
    }
  }

  void downloadFile({required String url, required String title}) {
    FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  void _receiveDataFromTeacherHomeworkListView() {
    clasId.value = Get.arguments['class_id'];
    sectionId.value = Get.arguments['section_id'];
    homeworkId.value = Get.arguments['homework_id'];
    subjectName.value = Get.arguments['subject_name'];
    assignDate.value = Get.arguments['assign_date'];
    submissionDate.value = Get.arguments['submission_date'];
    evaluation.value = Get.arguments['evaluation'];
    marks.value = Get.arguments['marks'];
    file.value = Get.arguments['file'];
    clasName.value = Get.arguments['class_name'];
    sectionName.value = Get.arguments['section_name'] ?? "";
  }

  @override
  void onInit() {
    _receiveDataFromTeacherHomeworkListView();
    getHomeworkEvaluationList("");

    super.onInit();
  }
}
