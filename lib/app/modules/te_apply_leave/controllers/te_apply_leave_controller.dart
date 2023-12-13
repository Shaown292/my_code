import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_leave/teacher_leave_type_list_response_model.dart';
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

  RxList<TeacherApplyLeaveTypeData> teacherLeaveTypeList =
      <TeacherApplyLeaveTypeData>[].obs;
  RxBool leaveLoader = false.obs;
  Rx<TeacherApplyLeaveTypeData> leaveTypeInitialValue =
      TeacherApplyLeaveTypeData(id: -1, name: "leave_type").obs;
  RxInt leaveTypeId = 0.obs;

  void changeApplyDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate();

    if (dateTime != null) {
      applyDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  void changeFromDate() async {
    DateTime? dateTime = await DatePickerUtils()
        .pickDate(canSelectPastDate: true, canSelectFutureDate: true);

    if (dateTime != null) {
      fromDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  void changeToDate() async {
    DateTime? dateTime = await DatePickerUtils()
        .pickDate(canSelectPastDate: true, canSelectFutureDate: true);

    if (dateTime != null) {
      toDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  bool validation() {
    if (leaveTypeInitialValue.value.id == -1) {
      showBasicFailedSnackBar(message: 'No leave type available.');
      return false;
    }
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

  Future<TeacherLeaveTypeListResponseModel>
      getTeacherApplyLeaveTypeList() async {
    try {
      leaveLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherLeaveType,
        header: GlobalVariable.header,
      );

      TeacherLeaveTypeListResponseModel teacherLeaveTypeListResponseModel =
          TeacherLeaveTypeListResponseModel.fromJson(response);
      if (teacherLeaveTypeListResponseModel.success == true) {
        leaveLoader.value = false;
        if (teacherLeaveTypeListResponseModel.data!.isNotEmpty) {
          for (var element in teacherLeaveTypeListResponseModel.data!) {
            teacherLeaveTypeList.add(element);
          }
          leaveTypeInitialValue.value = teacherLeaveTypeList.first;
          leaveTypeId.value = teacherLeaveTypeList.first.id!;
        }
      } else {
        leaveLoader.value = false;
        showBasicFailedSnackBar(
          message: teacherLeaveTypeListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      leaveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      leaveLoader.value = false;
    }

    return TeacherLeaveTypeListResponseModel();
  }

  void applyLeave() async {
    try {
      debugPrint(InfixApi.teacherApplyLeave);
      loadingController.isLoading = true;
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.teacherApplyLeave));
      request.headers['Authorization'] = GlobalVariable.token!;

      if (file.value.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('attach_file', file.value.path));
      }

      request.fields['type_id'] = leaveTypeId.toString();
      request.fields['apply_date'] = applyDateTextController.text;
      request.fields['leave_from'] = fromDateTextController.text;
      request.fields['leave_to'] = toDateTextController.text;
      request.fields['reason'] = reasonTextController.text;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: decodedResponse['message']);

        applyDateTextController.clear();
        fromDateTextController.clear();
        toDateTextController.clear();
        reasonTextController.clear();
        file.value = File('');
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  @override
  void onInit() {
    getTeacherApplyLeaveTypeList();

    super.onInit();
  }
}
