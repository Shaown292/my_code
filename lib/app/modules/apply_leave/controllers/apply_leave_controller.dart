import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_apply_leave_model/student_apply_leave_type_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/datepicker_dialogue/date_picker.dart';

class ApplyLeaveController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool isLoading = false.obs;

  TextEditingController applyDateTextController = TextEditingController();
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();
  TextEditingController reasonTextController = TextEditingController();

  bool isValidate = false;
  Rx<File> file = File('').obs;

  // List<LeaveType> applyLeaveTypeList = [];
  List<String> leaveTypeDropdownList = [];

  // RxList<LeaveType> leaveTypeDropdownList = <LeaveType>[].obs;
  // RxString dropdownValue = "".obs;
  RxInt leaveTypeId = 0.obs;
  Rx<LeaveType> dropdownValue = LeaveType(id: -1, name: "leave_type").obs;

  RxList<LeaveType> applyLeaveTypeList = <LeaveType>[].obs;

  void getStudentApplyLeaveTypeList({required int recordId}) async {
    try {
      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getStudentApplyLeaveType(roleId: GlobalVariable.roleId!),
        header: GlobalVariable.header,
      );

      StudentApplyLeaveTypeResponseModel studentApplyLeaveTypeResponseModel =
          StudentApplyLeaveTypeResponseModel.fromJson(response);
      if (studentApplyLeaveTypeResponseModel.success == true) {
        isLoading.value = false;
        if (studentApplyLeaveTypeResponseModel.data!.leaveType!.isNotEmpty) {
          for (int i = 0;
              i < studentApplyLeaveTypeResponseModel.data!.leaveType!.length;
              i++) {
            applyLeaveTypeList
                .add(studentApplyLeaveTypeResponseModel.data!.leaveType![i]);
            leaveTypeDropdownList.add(
                studentApplyLeaveTypeResponseModel.data!.leaveType![i].name ??
                    '');
          }
          dropdownValue.value = applyLeaveTypeList[0];
          leaveTypeId.value = applyLeaveTypeList[0].id!;
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
            message: studentApplyLeaveTypeResponseModel.message ??
                'Failed to load data');
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void changeApplyDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(canSelectPastDate: true,
      canSelectFutureDate: true,);

    if (dateTime != null) {
      applyDateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  void changeFromDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

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
    if (dropdownValue.value.id == -1) {
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

  void applyLeave() async {
    try {
      debugPrint(InfixApi.teacherApplyLeave);
      loadingController.isLoading = true;
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.studentApplyLeave));
      request.headers['Authorization'] = GlobalVariable.token!;

      if (file.value.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('attach_file', file.value.path));
      }

      request.fields['apply_date'] = applyDateTextController.text;
      request.fields['leave_from'] = fromDateTextController.text;
      request.fields['leave_to'] = toDateTextController.text;
      request.fields['reason'] = reasonTextController.text;
      request.fields['student_id'] = '${GlobalVariable.studentId!}';
      request.fields['leave_type'] = '$leaveTypeId';

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
    if (GlobalVariable.roleId == 2) {
      getStudentApplyLeaveTypeList(recordId: GlobalVariable.roleId!);
    }
    super.onInit();
  }
}
