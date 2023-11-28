import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

class AdminClassAttendanceSearchController extends GetxController {


  TextEditingController selectedDateTextController = TextEditingController();


  RxString classInitialValue = '1'.obs;
  RxString classNullValue = ''.obs;
  List<String> classList = [
    '1',
    '2',
    '3',
    '4'
  ];

  RxString sectionInitialValue = 'A'.obs;
  RxString sectionNullValue = ''.obs;
  List<String> sectionList = [
    'A',
    'B',
    'C',
    'D'
  ];


  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  bool validation() {
    if (classList.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Class');
      return false;
    }

    if (sectionList.isEmpty) {
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
