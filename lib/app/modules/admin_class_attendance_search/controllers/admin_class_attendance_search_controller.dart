import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_class_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_section_list_response_model.dart';
import 'package:get/get.dart';

class AdminClassAttendanceSearchController extends GetxController {


  TextEditingController selectedDateTextController = TextEditingController();

  LoadingController loadingController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController = Get.put(AdminStudentsSearchController());



  RxString classNullValue = ''.obs;


  RxString sectionNullValue = ''.obs;



  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.dd_mm_yyyy;
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

}
