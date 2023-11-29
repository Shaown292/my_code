import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_student_search_attendance_response_model.dart';
import 'package:get/get.dart';

class AdminClassSetAttendanceController extends GetxController {
  // LoadingController loadingController = Get.find();

  RxBool isSelected = false.obs;
  final selectIndex = RxInt(0);
  RxString status = "P".obs;
  RxBool isLoading = false.obs;

  int? studentClassId;
  int? studentSectionId;
  String? selectedDate;

  List<String> title = ["Present", "Absent", "Late", "Half Day"];
  AttendanceStudentData attendanceStudentList = AttendanceStudentData();

  @override
  void onInit() {
    attendanceStudentList = Get.arguments['student_attendance_list'];

    super.onInit();
  }
}
