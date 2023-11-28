import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/admin_student_search_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_class_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_section_list_response_model.dart';
import 'package:get/get.dart';

class AdminStudentsSearchController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool sectionLoader = false.obs;
  RxBool searchLoader = false.obs;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  Rx<ClassListData> classValue =
      ClassListData(id: -1, name: "Select Class Name").obs;

  RxList<ClassListData> classList = <ClassListData>[].obs;

  RxList<SectionListData> sectionList = <SectionListData>[].obs;
  Rx<SectionListData> sectionValue =
      SectionListData(id: -1, name: "Select Class Name").obs;
  RxList<StudentSearchData> studentSearchDataList = <StudentSearchData>[].obs;

  RxInt studentClassId = 0.obs;
  RxInt studentSectionId = 0.obs;

  // RxString classValue = "1".obs;

  RxList<String> classListDropdown = [
    "1",
    '2',
    "3",
    '4',
  ].obs;

  Future<StudentClassListResponseModel> getStudentClassList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getStudentClassList, header: GlobalVariable.header);

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

  Future<StudentSectionListResponseModel> getStudentSectionList(
      {required int classId}) async {
    try {
      sectionLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getStudentSectionList(classId: classId),
          header: GlobalVariable.header);

      StudentSectionListResponseModel studentSectionListResponseModel =
          StudentSectionListResponseModel.fromJson(response);

      sectionList.add(SectionListData(id: -1, name: "Select Section"));
      if (studentSectionListResponseModel.success == true) {
        sectionLoader.value = false;
        if (studentSectionListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentSectionListResponseModel.data!.length;
              i++) {
            sectionList.add(studentSectionListResponseModel.data![i]);
          }
          sectionValue.value = sectionList[0];
          studentSectionId.value = sectionList[0].id!;
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

  Future<AdminStudentSearchResponseModel> getSearchStudentDataList({
    required int classId,
    int? sectionId,
    int? rollId,
    String? name,
  }) async {
    try {
      searchLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminStudentSearchList(classId: classId),
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
        getStudentSectionList(classId: studentClassId.value);
      }
    });
    super.onInit();
  }
}
