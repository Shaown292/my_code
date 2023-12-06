import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_student_search_attendance_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminClassSetAttendanceController extends GetxController {
  RxBool saveLoader = false.obs;

  TextEditingController noteTextController = TextEditingController();

  RxBool isSelected = false.obs;
  final selectIndex = RxInt(0);
  RxString status = "P".obs;
  RxBool isLoading = false.obs;
  RxBool markHoliday = false.obs;
  RxBool holidayLoader = false.obs;

  int? studentClassId;
  int? studentSectionId;
  String? selectedDate;

  AttendanceStudentData attendanceStudentData = AttendanceStudentData();

  RxList<StudentsListData> adminClassSetAttendanceList =
      <StudentsListData>[].obs;

  RxList<int> recordIdList = <int>[].obs;
  RxList<int> studentIdList = <int>[].obs;
  RxList<String> attendanceTypeList = <String>[].obs;
  RxList<String> noteList = <String>[].obs;

  void setAttendanceData() {
    for (int i = 0; i < attendanceStudentData.students!.length; i++) {
      adminClassSetAttendanceList.add(attendanceStudentData.students![i]);
    }
  }

  void updateAttendance({
    required int index,
    required String attendanceType,
  }) {
    adminClassSetAttendanceList[index].attendanceType = attendanceType;

    adminClassSetAttendanceList.refresh();
  }

  void updateAttendanceNote({
    required int index,
    required String note,
  }) {
    adminClassSetAttendanceList[index].note = note;

    adminClassSetAttendanceList.refresh();
  }

  void dataFiltering() {
    recordIdList.clear();
    studentIdList.clear();
    attendanceTypeList.clear();
    noteList.clear();
    for (int i = 0; i < adminClassSetAttendanceList.length; i++) {
      recordIdList.add(adminClassSetAttendanceList[i].recordId!);
      studentIdList.add(adminClassSetAttendanceList[i].studentId!);
      attendanceTypeList
          .add(adminClassSetAttendanceList[i].attendanceType ?? '');
      noteList.add(adminClassSetAttendanceList[i].note ?? '');
    }

    uploadAttendance();
  }

  void uploadAttendance() async {
    try {

      saveLoader.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.adminSubmitStudentAttendance,
          header: GlobalVariable.header,
          payload: {
            'class': attendanceStudentData.classId,
            'section': attendanceStudentData.sectionId,
            'date': attendanceStudentData.date,
            'record_id': recordIdList,
            'student_id': studentIdList,
            'attendance_type': attendanceTypeList,
            'note': noteList,
          });

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        saveLoader.value = false;
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Upload Successful');
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }
  }

  Future<PostRequestResponseModel> markUnMarkHoliday(
      {required String purpose}) async {
    try {


      holidayLoader.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.adminAttendanceMarkUnMarkHolyDay,
          header: GlobalVariable.header,
          payload: {
            'purpose': purpose,
            'class_id': attendanceStudentData.classId,
            'section_id': attendanceStudentData.sectionId,
            'attendance_date': attendanceStudentData.date,
          });

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        holidayLoader.value = false;
        for (int i = 0; i < adminClassSetAttendanceList.length; i++) {
          adminClassSetAttendanceList[i].attendanceType =
              markHoliday.value ? '' : 'P';
        }
        adminClassSetAttendanceList.refresh();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Upload Successful');
      } else {
        holidayLoader.value = false;
        showBasicFailedSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      holidayLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      holidayLoader.value = false;
    }

    return PostRequestResponseModel();
  }

  @override
  void onInit() {
    attendanceStudentData = Get.arguments['student_attendance_list'];
    studentClassId = Get.arguments['class_id'];
    studentSectionId = Get.arguments['section_id'];
    setAttendanceData();
    super.onInit();
  }
}
