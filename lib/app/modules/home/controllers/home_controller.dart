import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_ui_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_record/student_record_response_model.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../database/auth_database.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';

class HomeController extends GetxController {

  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();

  List<HomeTileModelClass> homeTileList = <HomeTileModelClass>[];

  late ProfileInfoModel profileInfoModel;
  final AuthDatabase _authDatabase = AuthDatabase.instance;
  final selectIndex = RxInt(-1);
  List<StudentRecord> studentRecordList = [];
  List<String> studentRecordDropdownList = [];
  List<int> studentRecordIdList = [];



  // void _getUserInfo() {
  //   profileInfoModel = _authDatabase.getUserInfo()!;
  // }

  Future<PostRequestResponseModel> logout() async {
    LoadingController loadingController = Get.find();
    try {


      final response = await BaseClient().postData(
        url: InfixApi.logout,
        header: GlobalVariable.header,
      );

      PostRequestResponseModel postRequestResponseModel = PostRequestResponseModel.fromJson(response);

      if(postRequestResponseModel.success == true){
        await _authDatabase.logOut();

        Get.offNamedUntil('/secondary-splash', (route) => false);
        // Get.offNamedUntil('/splash', (route) => false);

        loadingController.isLoading = false;
      } else{
        await _authDatabase.logOut();

        Get.offNamedUntil('/secondary-splash', (route) => false);
        // Get.offNamedUntil('/splash', (route) => false);
        showBasicSuccessSnackBar(message: postRequestResponseModel.message ?? AppText.somethingWentWrong,);

        loadingController.isLoading = false;
      }

    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    } finally {
      await _authDatabase.logOut();
      // globalRxVariableController.token.value = null;
      // globalRxVariableController.userId.value = null;
      // globalRxVariableController.roleId.value = null;
      //
      // globalRxVariableController.notificationCount.value = null;
      // globalRxVariableController.studentRecordId.value = null;
      // globalRxVariableController.email.value = null;
      // globalRxVariableController.studentId.value = null;
      // globalRxVariableController.parentId.value = null;
      // globalRxVariableController.staffId.value = null;
      // globalRxVariableController.isStudent.value = false;

      Get.offNamedUntil('/secondary-splash', (route) => false);
      // Get.offNamedUntil('/splash', (route) => false);

      loadingController.isLoading = false;
    }


    return PostRequestResponseModel();
  }

  void getStudentRecord({required int studentId}) async {
    try {
      final response = await BaseClient().getData(
          url: InfixApi.getStudentRecord(studentId: studentId),
          header: GlobalVariable.header);

      StudentRecordResponseModel studentRecordResponseModel =
          StudentRecordResponseModel.fromJson(response);
      if (studentRecordResponseModel.success) {
        globalRxVariableController.studentRecordId.value =
            studentRecordResponseModel.data.studentRecords.first.id;
        if (studentRecordResponseModel.data.studentRecords.isNotEmpty) {
          for (int i = 0;
              i < studentRecordResponseModel.data.studentRecords.length;
              i++) {
            studentRecordList
                .add(studentRecordResponseModel.data.studentRecords[i]);
            globalRxVariableController.studentRecordId.value = studentRecordResponseModel.data.studentRecords.first.id;
            studentRecordDropdownList.add(
                'Class ${studentRecordResponseModel.data.studentRecords[i].studentRecordClass} (${studentRecordResponseModel.data.studentRecords[i].section})');
            studentRecordIdList
                .add(studentRecordResponseModel.data.studentRecords[i].id);
          }
        }
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }

  @override
  void onInit() {

    homeTileList = Get.arguments["homeListTile"];

    debugPrint(
        'Role ID: ${globalRxVariableController.roleId} :::: Record ID: ${globalRxVariableController.studentId}');
    if (globalRxVariableController.roleId.value == 2 ||
        globalRxVariableController.roleId.value == 3) {
      if (globalRxVariableController.isStudent.value) {
        if (globalRxVariableController.studentId.value != null) {
          getStudentRecord(
            studentId: globalRxVariableController.studentId.value!,
          );
        }
      }
    }
    super.onInit();
  }
}
