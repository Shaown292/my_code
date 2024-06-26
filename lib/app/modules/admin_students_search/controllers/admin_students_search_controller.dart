import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_student_subject_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/admin_student_search_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_class_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_section_list_response_model.dart';
import 'package:get/get.dart';

class AdminStudentsSearchController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();
  RxBool sectionLoader = false.obs;
  RxBool searchLoader = false.obs;
  RxBool subjectLoader = false.obs;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  Rx<ClassListData> classValue = ClassListData(id: -1, name: "").obs;
  RxList<ClassListData> classList = <ClassListData>[].obs;
  RxInt studentClassId = 0.obs;

  RxList<SectionListData> sectionList = <SectionListData>[].obs;
  Rx<SectionListData> sectionValue = SectionListData(id: -1, name: "").obs;
  RxInt studentSectionId = 0.obs;

  RxList<StudentSearchData> studentSearchDataList = <StudentSearchData>[].obs;

  Rx<SubjectData> subjectValue = SubjectData(id: -1, name: "").obs;
  RxList<SubjectData> subjectList = <SubjectData>[].obs;
  RxInt studentSubjectId = 0.obs;

  /// Get Admin / Teacher Student Class List
  Future<StudentClassListResponseModel> getStudentClassList() async {
    try {
      classList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.getAdminClassList
              : InfixApi.getTeacherClassList,
          header: GlobalVariable.header);

      StudentClassListResponseModel studentClassListResponseModel =
          StudentClassListResponseModel.fromJson(response);

      if (studentClassListResponseModel.success == true) {
        if (studentClassListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < studentClassListResponseModel.data!.length; i++) {
            classList.add(studentClassListResponseModel.data![i]);
          }
          classValue.value = classList[0];
          studentClassId.value = classList[0].id!;
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: studentClassListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return StudentClassListResponseModel();
  }

  /// Get Admin / Teacher Student Section List
  Future<StudentSectionListResponseModel> getStudentSectionList(
      {required int classId}) async {
    try {
      sectionList.clear();
      sectionLoader.value = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.getAdminSectionList(classId: classId)
              : InfixApi.getTeacherSectionList(classId: classId),
          header: GlobalVariable.header);

      StudentSectionListResponseModel studentSectionListResponseModel =
          StudentSectionListResponseModel.fromJson(response);

      if (studentSectionListResponseModel.success == true) {
        sectionLoader.value = false;
        if (studentSectionListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentSectionListResponseModel.data!.length;
              i++) {
            sectionList.add(studentSectionListResponseModel.data![i]);
          }
          sectionValue.value = sectionList.first;
          studentSectionId.value = sectionList.first.id!;

        }
      } else {
        sectionLoader.value = false;
        showBasicFailedSnackBar(
            message: studentSectionListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      sectionLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      sectionLoader.value = false;
    }

    return StudentSectionListResponseModel();
  }

  /// Get Admin / Teacher Student Subject List
  Future<AdminStudentSubjectListResponseModel> getAdminStudentSubjectList(
      {required int classId, required int sectionId}) async {
    try {
      subjectLoader.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminStudentSubjectList(
                classId: classId, sectionId: sectionId)
            : InfixApi.getTeacherStudentSubjectList(
                classId: classId,
                sectionId: sectionId,
              ),
        header: GlobalVariable.header,
      );

      AdminStudentSubjectListResponseModel
          adminStudentSubjectListResponseModel =
          AdminStudentSubjectListResponseModel.fromJson(response);

      if (adminStudentSubjectListResponseModel.success == true) {
        if (adminStudentSubjectListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminStudentSubjectListResponseModel.data!.length;
              i++) {
            subjectList.add(adminStudentSubjectListResponseModel.data![i]);
          }
          subjectValue.value = subjectList[0];
          studentSubjectId.value = subjectList[0].id!;
        }
      } else {
        subjectLoader.value = false;
        showBasicFailedSnackBar(
          message: adminStudentSubjectListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      subjectLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      subjectLoader.value = false;
    }

    return AdminStudentSubjectListResponseModel();
  }

  /// Get Student List against class, section, roll no & name
  Future<AdminStudentSearchResponseModel> getSearchStudentDataList({
    required int classId,
    required int sectionId,
    required String rollNo,
    required String name,
  }) async {
    try {
      studentSearchDataList.clear();
      searchLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminStudentSearchList(
            classId: classId,
            sectionId: sectionId,
            rollNo: rollNo,
            name: name,
          ),
          header: GlobalVariable.header);

      AdminStudentSearchResponseModel adminStudentSearchResponseModel =
          AdminStudentSearchResponseModel.fromJson(response);

      if (adminStudentSearchResponseModel.success == true) {
        searchLoader.value = false;
        if (adminStudentSearchResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminStudentSearchResponseModel.data!.length;
              i++) {
            studentSearchDataList.add(adminStudentSearchResponseModel.data![i]);
          }
          Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH_LIST,
              arguments: {'search_data': studentSearchDataList});
        } else {
          Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH_LIST,
              arguments: {'search_data': studentSearchDataList});
        }
      } else {
        searchLoader.value = false;
        showBasicFailedSnackBar(
            message: adminStudentSearchResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      searchLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchLoader.value = false;
    }

    return AdminStudentSearchResponseModel();
  }

  @override
  void onInit() {
    getStudentClassList().then((value) {
      if (classList.isNotEmpty) {
        getStudentSectionList(classId: studentClassId.value).then((value) {
          if (sectionList.isNotEmpty) {
            getAdminStudentSubjectList(
                classId: studentClassId.value,
                sectionId: studentSectionId.value);
          }
        });
      }
    });
    super.onInit();
  }
}
