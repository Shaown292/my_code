import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/admin_student_search_response_model.dart';
import 'package:get/get.dart';

class AdminStudentsSearchListController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController = Get.find();
  List<StudentSearchData>? studentData;

  @override
  void onInit() {

    studentData = Get.arguments['search_data'];

    super.onInit();
  }

}
