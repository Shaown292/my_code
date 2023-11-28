import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_class_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_student_model/student_section_list_response_model.dart';
import 'package:get/get.dart';

class AdminStudentsSearchController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool sectionLoader = false.obs;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  RxList<ClassListData> classList = <ClassListData>[].obs;
  RxList<SectionListData> sectionList = <SectionListData>[].obs;
  RxInt studentClassId = 0.obs;
  RxInt studentSectionId = 0.obs;

  RxString classValue = "1".obs;

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

      if (studentSectionListResponseModel.success == true) {
        sectionLoader.value = false;
        if (studentSectionListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentSectionListResponseModel.data!.length;
              i++) {
            sectionList.add(studentSectionListResponseModel.data![i]);
          }
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

  @override
  void onInit() {
    getStudentClassList().then(
        (value) => getStudentSectionList(classId: studentSectionId.value));
    super.onInit();
  }
}
