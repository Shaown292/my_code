import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_student_search_attendance_response_model.dart';
import 'package:get/get.dart';

import '../../../../domain/core/model/admin/admin_attendance_model/admin_set_attendance_ui_model.dart';

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

  RxList<AdminSetAttendanceUIModel> adminClassSetAttendanceUIModel= <AdminSetAttendanceUIModel>[].obs;

  @override
  void onInit() {

    attendanceStudentList = Get.arguments['student_attendance_list'];
    studentClassId = Get.arguments['class_id'];
    studentSectionId = Get.arguments['section_id'];
    setAttendanceData();
    super.onInit();
  }


  void setAttendanceData (){

    int id = 1;
    attendanceStudentList.students?.forEach((student) {
      adminClassSetAttendanceUIModel.add(
          AdminSetAttendanceUIModel(
            studentId: id++,
            section: studentSectionId,
            attendanceType: student.attendanceType,
            note: student.note,
            studentClass: studentClassId,
            date: attendanceStudentList.date,
          )
      );
    });
  }


  void updateAttendance ({required AdminSetAttendanceUIModel student, required String attendanceType}) {

    int index = adminClassSetAttendanceUIModel.indexWhere((element) => element.studentId == student.studentId) ;

  if(index != -1) {

    adminClassSetAttendanceUIModel[index].attendanceType = attendanceType;
    adminClassSetAttendanceUIModel.refresh();

  }



  }
}
