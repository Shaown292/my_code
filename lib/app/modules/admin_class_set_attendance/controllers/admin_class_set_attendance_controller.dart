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
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_student_search_attendance_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminClassSetAttendanceController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
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
    noteTextController.clear();
    Get.back();
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
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.adminSubmitStudentAttendance
              : InfixApi.teacherSubmitStudentAttendance,
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

 void markUnMarkHoliday() async {
    try {
      holidayLoader.value = true;

      final response = await BaseClient().postData(
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.adminAttendanceMarkUnMarkHolyDay
              : InfixApi.teacherAttendanceMarkUnMarkHolyDay,
          header: GlobalVariable.header,
          payload: {
            'purpose': markHoliday.value ? "unmark" : "",
            'class_id': attendanceStudentData.classId,
            'section_id': attendanceStudentData.sectionId,
            'attendance_date': attendanceStudentData.date,
          });

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {

        holidayLoader.value = false;
        markHoliday.value = !markHoliday.value;
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

    // return PostRequestResponseModel();
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
                  PrimaryButton(
                    width: Get.width * 0.2,
                    title: "Save",
                    textStyle: AppTextStyle.textStyle12WhiteW500,
                    onTap: () => updateAttendanceNote(
                        index: index, note: noteTextController.text),
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
    attendanceStudentData = Get.arguments['student_attendance_list'];
    studentClassId = Get.arguments['class_id'];
    studentSectionId = Get.arguments['section_id'];
    setAttendanceData();
    super.onInit();
  }
}
