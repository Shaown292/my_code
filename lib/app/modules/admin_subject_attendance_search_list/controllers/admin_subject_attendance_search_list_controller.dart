import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_sub_search_attendance_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchListController extends GetxController {


  RxInt selectIndex = 0.obs;


  RxInt classId = 0.obs;
  RxInt sectionId = 0.obs;
  RxInt subjectId = 0.obs;
  RxString attendanceDate = ''.obs;
  RxBool isLoading = false.obs;
  RxBool saveLoader = false.obs;
  RxBool markHoliday = false.obs;
  RxBool holidayLoader = false.obs;

  RxList<AdminStudentsSubSearchData> adminStudentSubSearchList =
      <AdminStudentsSubSearchData>[].obs;

  RxList<int> recordIdList = <int>[].obs;
  RxList<int> studentIdList = <int>[].obs;
  RxList<String> attendanceTypeList = <String>[].obs;
  RxList<String> noteList = <String>[].obs;

  Future<AdminSubSearchAttendanceResponseModel>
      getAdminStudentSubjectSearchList({
    required int studentClassId,
    required int studentSectionId,
    required int studentSubjectId,
    required String studentAttendanceDate,
  }) async {
    try {
      adminStudentSubSearchList.clear();
      isLoading.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.getAdminSubjectSearchAttendanceList(
          classId: studentClassId,
          sectionId: studentSectionId,
          subjectId: studentSubjectId,
          attendanceDate: studentAttendanceDate,
        ),
        header: GlobalVariable.header,
      );

      AdminSubSearchAttendanceResponseModel
          adminSubSearchAttendanceResponseModel =
          AdminSubSearchAttendanceResponseModel.fromJson(response);

      if (adminSubSearchAttendanceResponseModel.success == true) {
        isLoading.value = false;
        classId.value = adminSubSearchAttendanceResponseModel.data!.classId!;
        sectionId.value = adminSubSearchAttendanceResponseModel.data!.classId!;
        subjectId.value = adminSubSearchAttendanceResponseModel.data!.classId!;
        attendanceDate.value = adminSubSearchAttendanceResponseModel.data!.date!;
        if (adminSubSearchAttendanceResponseModel.data!.students!.isNotEmpty) {
          for (int i = 0;
              i < adminSubSearchAttendanceResponseModel.data!.students!.length;
              i++) {
            adminStudentSubSearchList
                .add(adminSubSearchAttendanceResponseModel.data!.students![i]);
          }
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
          message: adminSubSearchAttendanceResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return AdminSubSearchAttendanceResponseModel();
  }






  void updateAttendanceStatus({
    required int index,
    required String attendanceType,
  }) {
    adminStudentSubSearchList[index].attendanceType = attendanceType;

    adminStudentSubSearchList.refresh();
  }

  void updateAttendanceNote({
    required int index,
    required String note,
  }) {
    adminStudentSubSearchList[index].note = note;

    adminStudentSubSearchList.refresh();
  }

  void dataFilteringForApiCall() {
    recordIdList.clear();
    studentIdList.clear();
    attendanceTypeList.clear();
    noteList.clear();
    for (int i = 0; i < adminStudentSubSearchList.length; i++) {
      recordIdList.add(adminStudentSubSearchList[i].recordId!);
      studentIdList.add(adminStudentSubSearchList[i].studentId!);
      attendanceTypeList
          .add(adminStudentSubSearchList[i].attendanceType ?? '');
      noteList.add(adminStudentSubSearchList[i].note ?? '');
    }

    uploadAttendance();
  }

  Future<PostRequestResponseModel> uploadAttendance() async {


    try {

      saveLoader.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.adminSubmitSubjectWiseStudentAttendance,
          header: GlobalVariable.header,
          payload: {
            'class': classId.value,
            'section': sectionId.value,
            'subject_id': subjectId.value,
            'date': attendanceDate.value,
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

    return PostRequestResponseModel();
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
            'class_id': classId.value,
            'section_id': sectionId.value,
            'attendance_date': attendanceDate.value,
          });

      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        holidayLoader.value = false;
        for (int i = 0; i < adminStudentSubSearchList.length; i++) {
          adminStudentSubSearchList[i].attendanceType =
          markHoliday.value ? '' : 'P';
        }
        adminStudentSubSearchList.refresh();
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
    classId.value = Get.arguments['class_id'];
    sectionId.value = Get.arguments['section_id'];
    subjectId.value = Get.arguments['subject_id'];
    attendanceDate.value = Get.arguments['date'];

    getAdminStudentSubjectSearchList(
        studentClassId: classId.value,
        studentSectionId: sectionId.value,
        studentSubjectId: subjectId.value,
        studentAttendanceDate: attendanceDate.value);

    super.onInit();
  }
}
