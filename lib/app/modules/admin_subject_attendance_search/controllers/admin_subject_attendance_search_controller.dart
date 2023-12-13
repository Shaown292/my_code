import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminSubjectAttendanceSearchController extends GetxController {
  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController());

  TextEditingController selectedDateTextController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
  );

  RxString classNullValue = ''.obs;
  RxString sectionNullValue = ''.obs;
  RxString subjectNullValue = ''.obs;

  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.yyyy_mm_dd;
    }
  }

  bool validation() {
    if (adminStudentsSearchController.studentClassId.value == 0) {
      showBasicFailedSnackBar(message: 'Select class.');
      return false;
    }
    if (adminStudentsSearchController.studentSectionId.value == 0) {
      showBasicFailedSnackBar(message: 'Select section.');
      return false;
    }
    if (adminStudentsSearchController.studentSubjectId.value == 0) {
      showBasicFailedSnackBar(message: 'Select subject');
      return false;
    }


    return true;
  }
}
