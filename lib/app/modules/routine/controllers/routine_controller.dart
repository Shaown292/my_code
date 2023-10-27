import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_routine_model/StudentRoutineResponseModel.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';

class RoutineController extends GetxController {

  TabController? tabController;
  List<ClassRoutine> classRoutineList = [];

  // TabController tabController = TabController(length: length, vsync: vsync)

  LoadingController loadingController = Get.find();

  List<String> daysOfWeek = <String>[
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

  void getSyllabusList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentRoutineList(
          GlobalVariableController.roleId!,
          GlobalVariableController.studentRecordId!,
        ),
        header: GlobalVariableController.header,
      );

      StudentRoutineResponseModel studentRoutineResponseModel =
          StudentRoutineResponseModel.fromJson(response);
      if (studentRoutineResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentRoutineResponseModel.data.classRoutines.isNotEmpty) {
          for (int i = 0;
              i < studentRoutineResponseModel.data.classRoutines.length;
              i++) {
            classRoutineList
                .add(studentRoutineResponseModel.data.classRoutines[i]);
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
    getSyllabusList();
    super.onInit();
  }
}
