import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class AdminAddContentController extends GetxController {

  TextEditingController titleTextController = TextEditingController();
  TextEditingController selectedDateTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  LoadingController loadingController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController = Get.put(AdminStudentsSearchController());


  RxBool sectionLoader = false.obs;
  RxBool isStudent = false.obs;
  RxBool isAllStudent = false.obs;
  RxBool isStudentSelected = false.obs;
  RxBool isAdminSelected = false.obs;
  RxString contentInitialValue = "Assignment".obs;
  RxString selectedAdminOption = "All Admin".obs;
  RxString selectedStudentOption = "".obs;
  RxString classNullValue = ''.obs;
  RxString sectionNullValue = ''.obs;
  Rx<File> file = File('').obs;


  RxList<String> contentList = [
    "Assignment",
    "Syllabus",
    "Other Downloads"
  ].obs;

  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.dd_mm_yyyy;
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

}
