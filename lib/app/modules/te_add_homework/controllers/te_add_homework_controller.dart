import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_homework_model/teacher_class_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_homework_model/teacher_section_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_homework_model/teacher_subject_list_response_model.dart';
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


  /// Class, Subject & section Api call
  RxBool classLoader = false.obs;
  RxBool subjectLoader = false.obs;
  RxBool sectionLoader = false.obs;

  RxList<TeacherClassListData> teacherClassList = <TeacherClassListData>[].obs;
  RxList<TeachetSubjectListData> teacherSubjectList = <TeachetSubjectListData>[].obs;
  RxList<TeacherSectionListData> teacherSectionList = <TeacherSectionListData>[].obs;

  RxInt teacherClassId = 0.obs;
  RxInt teacherSubjectId = 0.obs;
  RxInt teacherSectionId = 0.obs;

  /// Add homework dropdown class list
  Future<TeacherClassListResponseModel> getTeacherClassList() async {
    try {
      teacherClassList.clear();
      classLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherAddHomeworkClassList,
        header: GlobalVariable.header,
      );

      TeacherClassListResponseModel teacherClassListResponseModel =
      TeacherClassListResponseModel.fromJson(response);

      if (teacherClassListResponseModel.success == true) {
        classLoader.value = false;
        if (teacherClassListResponseModel.data!.isNotEmpty) {
          for (var element in teacherClassListResponseModel.data!) {
            teacherClassList.add(element);
          }
          teacherClassId.value = teacherClassListResponseModel.data!.first.id!;
        }
      } else {
        classLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherClassListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      classLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      classLoader.value = false;
    }

    return TeacherClassListResponseModel();
  }

  /// Add homework dropdown Subject list
  Future<TeacherSubjectListResponseModel> getTeacherSubjectList({required int classId}) async {
    try {
      teacherSubjectList.clear();
      subjectLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherAddHomeworkSubjectList(classId: classId),
        header: GlobalVariable.header,
      );

      TeacherSubjectListResponseModel teacherSubjectListResponseModel =
      TeacherSubjectListResponseModel.fromJson(response);

      if (teacherSubjectListResponseModel.success == true) {
        subjectLoader.value = false;
        if (teacherSubjectListResponseModel.data!.isNotEmpty) {
          for (var element in teacherSubjectListResponseModel.data!) {
            teacherSubjectList.add(element);
          }
          teacherSubjectId.value = teacherSubjectListResponseModel.data!.first.id!;
        }
      } else {
        subjectLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherSubjectListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      subjectLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      subjectLoader.value = false;
    }

    return TeacherSubjectListResponseModel();
  }


  /// Add homework dropdown Section list
  Future<TeacherSectionListResponseModel> getTeacherSectionList({required int classId, required int subjectId}) async {
    try {
      teacherSectionList.clear();
      sectionLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherAddHomeworkSectionList(classId: classId, subjectId: subjectId,),
        header: GlobalVariable.header,
      );

      TeacherSectionListResponseModel teacherSectionListResponseModel =
      TeacherSectionListResponseModel.fromJson(response);

      if (teacherSectionListResponseModel.success == true) {
        sectionLoader.value = false;
        if (teacherSectionListResponseModel.data!.isNotEmpty) {
          for (var element in teacherSectionListResponseModel.data!) {
            teacherSectionList.add(element);
          }
        }
      } else {
        sectionLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherSectionListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      sectionLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      sectionLoader.value = false;
    }

    return TeacherSectionListResponseModel();
  }


  @override
  void onInit() {
    getTeacherClassList().then((value) {
      if(teacherClassList.isNotEmpty){
        getTeacherSubjectList(classId: teacherClassId.value).then((value) {
          if(teacherSubjectList.isNotEmpty){
            getTeacherSectionList(classId: teacherClassId.value, subjectId: teacherSubjectId.value);
          }
        },);
      }
    },);
    super.onInit();
  }


}
