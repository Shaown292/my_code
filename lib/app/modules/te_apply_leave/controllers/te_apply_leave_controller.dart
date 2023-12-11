import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class TeApplyLeaveController extends GetxController {

  LoadingController loadingController = Get.find();
  RxBool isLoading = false.obs;

  TextEditingController applyDateTextController = TextEditingController();
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();
  TextEditingController reasonTextController = TextEditingController();

  bool isValidate = false;
  Rx<File> file = File('').obs;

  RxString  dropdownValue = "Sick Leave".obs;
  RxList<String> applyLeaveTypeList = ["Sick Leave", 'Casual Leave', 'Make up Leave'].obs;

  void changeApplyDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate();

    if (dateTime != null) {
      applyDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  void changeFromDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate( canSelectPastDate: true , canSelectFutureDate: true);


    if (dateTime != null) {
      fromDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  void changeToDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(canSelectPastDate: true , canSelectFutureDate: true);

    if (dateTime != null) {
      toDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  bool validation() {
    // if (dropdownValue.value.id == -1) {
    //   showBasicFailedSnackBar(message: 'No leave type available.');
    //   return false;
    // }
    if (applyDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Apply Date.');
      return false;
    }
    if (fromDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select From Date.');
      return false;
    }
    if (toDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select To Date.');
      return false;
    }

    return true;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      file.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'canceled file selection');
      debugPrint("User canceled file selection");
    }
  }



  @override
  void onInit() {

    super.onInit();
  }
}
