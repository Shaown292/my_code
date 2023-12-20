import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
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

  void logout() async {
    LoadingController loadingController = Get.find();
    try {
      // var headers = {
      //   'Authorization': GlobalVariableController.token!,
      // };
      // var request = http.Request('POST', Uri.parse('https://spondan.com/infixedu/api/v2/auth/logout'));
      //
      // request.headers.addAll(headers);
      //
      // http.StreamedResponse response = await request.send();
      //
      // if (response.statusCode == 200) {
      //   print('::::::::::::::');
      //   print(await response.stream.bytesToString());
      // }
      // else {
      //   print('falseeeeeee');
      //   print(response.statusCode);
      //   print(response.reasonPhrase);
      // }

      // // loadingController.isLoading = true;
      // // bool result = await _authRepository.signOut();
      //
      // final res = await BaseClient().postData(
      //   url: InfixApi.logout(),
      //   header: {
      //     'Content-Type': 'application/json',
      //     'Authorization': GlobalVariableController.token!,
      //   },
      // );
      //
      // print(res);
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    } finally {
      await _authDatabase.logOut();
      globalRxVariableController.token.value = null;
      globalRxVariableController.userId.value = null;
      globalRxVariableController.roleId.value = null;

      // loadingController.isLoading = false;
      // Get.offAndToNamed(Routes.SPLASH);

      Get.offNamedUntil('/splash', (route) => false);

      loadingController.isLoading = false;
    }
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
