import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_sub_search_attendance_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchListController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  TextEditingController noteTextController = TextEditingController();

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
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminSubjectSearchAttendanceList(
                classId: studentClassId,
                sectionId: studentSectionId,
                subjectId: studentSubjectId,
                attendanceDate: studentAttendanceDate,
              )
            : InfixApi.getTeacherSubjectSearchAttendanceList(
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
        attendanceDate.value =
            adminSubSearchAttendanceResponseModel.data!.date!;
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
    noteTextController.clear();
    Get.back();
  }

  void dataFilteringForApiCall() {
    recordIdList.clear();
    studentIdList.clear();
    attendanceTypeList.clear();
    noteList.clear();
    for (int i = 0; i < adminStudentSubSearchList.length; i++) {
      recordIdList.add(adminStudentSubSearchList[i].recordId!);
      studentIdList.add(adminStudentSubSearchList[i].studentId!);
      attendanceTypeList.add(adminStudentSubSearchList[i].attendanceType ?? '');
      noteList.add(adminStudentSubSearchList[i].note ?? '');
    }

    uploadAttendance();
  }

  Future<PostRequestResponseModel> uploadAttendance() async {
    try {
      saveLoader.value = true;

      final response = await BaseClient().postData(
          url: globalRxVariableController.roleId.value == 1 ?  InfixApi.adminSubmitSubjectWiseStudentAttendance : InfixApi.teacherSubmitSubjectWiseStudentAttendance,
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
          url: globalRxVariableController.roleId.value == 1 ? InfixApi.adminAttendanceMarkUnMarkHolyDay : InfixApi.teacherSubjectWiseAttendanceMarkUnMarkHolyDay,
          header: GlobalVariable.header,
          payload: {
            'purpose': purpose,
            'class_id': classId.value,
            'section_id': sectionId.value,
            'subject_id': subjectId.value,
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

  void showAddNoteBottomSheet({
    required int index,
    Color? color,
    Function()? onUploadTap,
    Function()? onTapForSave,
  }) {
    Get.bottomSheet(
      Container(
        color: color,
        height: Get.height * 0.4,
        child: Column(
          children: [
            Container(
              height: Get.height * 0.1,
              width: Get.width,
              padding: const EdgeInsets.all(20),
              color: AppColors.primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Note",
                    style: AppTextStyle.cardTextStyle14WhiteW500,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpacing,
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: CustomTextFormField(
                controller: noteTextController,
                enableBorderActive: true,
                focusBorderActive: true,
                fillColor: Colors.white,
                hintText: "Add Note",
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    width: Get.width * 0.15,
                    title: "Cancel",
                    color: Colors.white,
                    textStyle: AppTextStyle.fontSize13BlackW400,
                    borderColor: AppColors.primaryColor,
                    onTap: () => Get.back(),
                  ),
                  Obx(
                    () => saveLoader.value == true
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : PrimaryButton(
                            width: Get.width * 0.2,
                            title: "Save",
                            textStyle: AppTextStyle.textStyle12WhiteW500,
                      onTap: ()=> updateAttendanceNote(index: index, note: noteTextController.text),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
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
