import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_student_search_attendance_response_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminClassAttendanceSearchController extends GetxController {
  TextEditingController selectedDateTextController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());

  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController());

  AttendanceStudentData attendanceStudentListData = AttendanceStudentData();
  RxBool isLoading = false.obs;

  RxString classNullValue = ''.obs;

  RxString sectionNullValue = ''.obs;

  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.yyyy_mm_dd;
    }
  }

  bool validation() {
    if (adminStudentsSearchController.classList.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Class');
      return false;
    }

    if (adminStudentsSearchController.sectionList.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Section');
      return false;
    }

    if (selectedDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Date');
      return false;
    }

    return true;
  }

  Future<AdminStudentSearchAttendanceResponseModel> getStudentAttendanceList({
    required int studentClassId,
    required int studentSectionId,
    required String selectedDate,
  }) async {
    try {
      isLoading.value = true;

      final response = await BaseClient().postData(
        url: GlobalVariable.roleId == 1
            ? InfixApi.getAdminStudentSearchAttendanceList(
                classId: studentClassId,
                sectionId: studentSectionId,
                selectedDate: selectedDate,
              )
            : InfixApi.getTeacherStudentSearchAttendanceList(
                classId: studentClassId,
                sectionId: studentSectionId,
                selectedDate: selectedDate,
              ),
        header: GlobalVariable.header,
      );

      AdminStudentSearchAttendanceResponseModel
          adminStudentSearchAttendanceResponseModel =
          AdminStudentSearchAttendanceResponseModel.fromJson(response);

      if (adminStudentSearchAttendanceResponseModel.success == true) {
        isLoading.value = false;

        attendanceStudentListData =
            adminStudentSearchAttendanceResponseModel.data!;

        Get.toNamed(Routes.ADMIN_CLASS_SET_ATTENDANCE, arguments: {
          'student_attendance_list': attendanceStudentListData,
          'class_id': studentClassId,
          'section_id': studentSectionId,
        });

        // attendanceStudentListData.students?.forEach((studentInfo) {
        //
        // });
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
          message: adminStudentSearchAttendanceResponseModel.message ??
              AppText.somethingWentWrong,
        );
        Get.toNamed(Routes.ADMIN_CLASS_SET_ATTENDANCE, arguments: {
          'student_attendance_list': attendanceStudentListData,
        });
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return AdminStudentSearchAttendanceResponseModel();
  }
}
