import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_sub_atten_search_individual_response_model.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchIndividualController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController());

  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  RxString classNullValue = ''.obs;
  RxString sectionNullValue = ''.obs;
  RxString subjectNullValue = ''.obs;
  RxInt subjectNameId = 0.obs;

  RxBool searchLoader = false.obs;
  RxList<AdminSubAttenStudents> adminSubAttendanceList =
      <AdminSubAttenStudents>[].obs;

  /// Get Student List against class, section, roll no & name
  Future<AdminSubAttenSearchIndividualResponseModel> getSearchStudentDataList({
    required int classId,
    required int sectionId,
    required int subjectId,
    required String rollNo,
    required String name,
  }) async {
    try {
      adminSubAttendanceList.clear();
      searchLoader.value = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1 ? InfixApi.getAdminSubAttenSearchList(
            classId: classId,
            sectionId: sectionId,
            rollINo: rollNo,
            name: name,
            subjectId: subjectId,
          ) : InfixApi.getTeacherSubAttenSearchList(
            classId: classId,
            sectionId: sectionId,
            rollINo: rollNo,
            name: name,
            subjectId: subjectId,
          ),
          header: GlobalVariable.header);

      AdminSubAttenSearchIndividualResponseModel
          adminSubAttenSearchIndividualResponseModel =
          AdminSubAttenSearchIndividualResponseModel.fromJson(response);

      if (adminSubAttenSearchIndividualResponseModel.success == true) {
        searchLoader.value = false;
        subjectNameId.value = adminSubAttenSearchIndividualResponseModel.data!.subjectNameId!;
        if (adminSubAttenSearchIndividualResponseModel
            .data!.students!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminSubAttenSearchIndividualResponseModel
                      .data!.students!.length;
              i++) {
            adminSubAttendanceList.add(
                adminSubAttenSearchIndividualResponseModel.data!.students![i]);
          }
          Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_LIST,
              arguments: {
                'search_data': adminSubAttendanceList,
                'subject_name_id': subjectNameId.value,
              });
        } else {
          Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_LIST,
              arguments: {
                'search_data': adminSubAttendanceList,
                'subject_name_id': subjectNameId.value,
              });
        }
      } else {
        searchLoader.value = false;
        showBasicFailedSnackBar(
            message: adminSubAttenSearchIndividualResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      searchLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchLoader.value = false;
    }

    return AdminSubAttenSearchIndividualResponseModel();
  }


}
