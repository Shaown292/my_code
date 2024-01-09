import 'package:flutter/foundation.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_homework_model/te_homework_evaluation_list_response_model.dart';
import 'package:get/get.dart';

class TeHomeworkEvaluationController extends GetxController {
  RxInt clasId = 0.obs;
  RxInt sectionId = 0.obs;
  RxInt homeworkId = 0.obs;

  final subjectName = Rxn<String>();
  final assignDate = Rxn<String>();
  final submissionDate = Rxn<String>();
  final evaluation = Rxn<String>();
  final file = Rxn<String>();
  final marks = Rxn<int>();

  RxBool isLoading = false.obs;

  RxList<EvaluationSubjectData> evaluationSubjectList =
      <EvaluationSubjectData>[].obs;

  Future<TeHomeworkEvaluationListResponseModel>
      getHomeworkEvaluationList() async {
    try {
      evaluationSubjectList.clear();
      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherHomeworkEvaluationList(
          classId: clasId.value,
          sectionId: sectionId.value,
          homeworkId: homeworkId.value,
        ),
        header: GlobalVariable.header,
      );

      TeHomeworkEvaluationListResponseModel
          teHomeworkEvaluationListResponseModel =
          TeHomeworkEvaluationListResponseModel.fromJson(response);

      if (teHomeworkEvaluationListResponseModel.success == true) {
        isLoading.value = false;
        if (teHomeworkEvaluationListResponseModel.data!.subject!.isNotEmpty) {
          for (var element
              in teHomeworkEvaluationListResponseModel.data!.subject!) {
            evaluationSubjectList.add(element);
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

  void _receiveDataFromTeacherHomeworkListView(){
    clasId.value = Get.arguments['class_id'];
    sectionId.value = Get.arguments['section_id'];
    homeworkId.value = Get.arguments['homework_id'];

    subjectName.value = Get.arguments['subject_name'];
    assignDate.value = Get.arguments['assign_date'];
    submissionDate.value = Get.arguments['submission_date'];
    evaluation.value = Get.arguments['evaluation'];
    marks.value = Get.arguments['marks'];
    file.value = Get.arguments['file'];
  }


  void downloadFile({required String url, required String title}) {
    FileDownloadUtils().downloadFiles(url: url, title: title);
  }
  @override
  void onInit() {

    _receiveDataFromTeacherHomeworkListView();

    getHomeworkEvaluationList();

    super.onInit();
  }
}
