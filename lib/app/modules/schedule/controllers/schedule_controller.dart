import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/examination/controllers/examination_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_exam_schedule/student_exam_schedule_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class ScheduleController extends GetxController {
  ExaminationController examinationController = Get.find();
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  // List<String> dropdownList = [];
  List<ScheduleData> scheduleList = [];
  RxString dropdownValue = "".obs;
  RxString recordDropdownValue = "".obs;

  void getStudentExamScheduleList(
      {required int examId, required recordId}) async {
    try {
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
        url: InfixApi.getStudentExamSchedule(examId, recordId),
        header: GlobalVariableController.header,
      );

      StudentExamScheduleResponseModel studentExamScheduleResponseModel =
          StudentExamScheduleResponseModel.fromJson(response);
      if (studentExamScheduleResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentExamScheduleResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentExamScheduleResponseModel.data!.length;
              i++) {
            scheduleList.add(studentExamScheduleResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: studentExamScheduleResponseModel.message ??
                'Failed to load data');
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
    if (examinationController.examList.isNotEmpty) {
      // dropdownList = examinationController.examDropdownList;
      dropdownValue.value = examinationController.examDropdownList[0];
      recordDropdownValue.value = homeController.studentRecordDropdownList[0];

      getStudentExamScheduleList(
          examId: examinationController.examList[0].id!,
          recordId: homeController.studentRecordList[0].id);
    }

    super.onInit();
  }
}
