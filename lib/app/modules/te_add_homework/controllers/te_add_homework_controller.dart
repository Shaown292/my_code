import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

class TeAddHomeworkController extends GetxController {

  TextEditingController assignDateTextController = TextEditingController();
  TextEditingController submissionDateTextController = TextEditingController();
  TextEditingController marksTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  Rx<File> file = File('').obs;

  RxString classInitialValue = "one".obs;
  RxList<String> classList = ["one", "two", "three"].obs;

  RxString sectionInitialValue = "A".obs;
  RxList<String> sectionList = ["A", "B", "C"].obs;

  void assignDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(canSelectPastDate: true);

    if (dateTime != null) {
      assignDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }
  void submissionDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(canSelectFutureDate: true);

    if (dateTime != null) {
      submissionDateTextController.text = dateTime.dd_mm_yyyy;
    }
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
  bool validation() {


    if (marksTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Add Marks');
      return false;
    }
    if (descriptionTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Add Description');
      return false;
    }

    return true;
  }
}
