import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchController extends GetxController {

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

  RxString subjectInitialValue = 'Eng'.obs;
  RxString subjectNullValue = ''.obs;
  List<String> subjectList = [
    'Eng',
    'Mat',
    'Ban',
    'His'
  ];

  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }


}
