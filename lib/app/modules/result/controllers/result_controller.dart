import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/examination/controllers/examination_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_exam_result/student_exam_result_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';

class ResultController extends GetxController {
  LoadingController loadingController = Get.find();
  ExaminationController examinationController = Get.find();
  HomeController homeController = Get.find();
  final selectIndex = RxInt(0);
  RxBool isSelected = false.obs;

  List<String> classInfo = <String>[
    'Class(A)',
    'Class(B)',
    'Class(C)',
    'Class(D)',
    'Class(E)',
  ];
  List<ExamResult> examResultList = [];
  int? currentExamId;
  int? currentRecordId;

  void _initializeId() {
    if (examinationController.examList.isNotEmpty &&
        homeController.studentRecordList.isNotEmpty) {
      currentExamId = examinationController.examList[0].id;
      currentRecordId = homeController.studentRecordList[0].id;
    }
  }

  void getStudentExamResultList(
      {required int examId, required int recordId}) async {
    try {
      loadingController.isLoading = true;

      if (examinationController.examList.isNotEmpty &&
          homeController.studentRecordList.isNotEmpty) {
        final response = await BaseClient().getData(
          url: InfixApi.getStudentExamResultList(
              examId: examId, recordId: recordId),
          header: GlobalVariableController.header,
        );

        StudentExamResultResponseModel studentExamResultResponseModel =
            StudentExamResultResponseModel.fromJson(response);
        if (studentExamResultResponseModel.success == true) {
          loadingController.isLoading = false;
          if (studentExamResultResponseModel.data!.examResult!.isNotEmpty) {
            for (int i = 0;
                i < studentExamResultResponseModel.data!.examResult!.length;
                i++) {
              examResultList
                  .add(studentExamResultResponseModel.data!.examResult![i]);
            }
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  @override
  void onInit() {
    _initializeId();
    getStudentExamResultList(
        examId: examinationController.examList[0].id!,
        recordId: homeController.studentRecordList[0].id);
    super.onInit();
  }
}
