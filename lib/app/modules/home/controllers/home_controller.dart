import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_ui_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_record/student_record_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    debugPrint('Role ID: ${GlobalVariableController.roleId} :::: Record ID: ${GlobalVariableController.studentId}');
    if(GlobalVariableController.roleId == 2){
      getStudentRecord();
    }
    super.onInit();
  }

  late ProfileInfoModel profileInfoModel;
  final AuthDatabase _authDatabase = AuthDatabase.instance;
  final selectIndex = RxInt(-1);
  List<StudentRecord> studentRecordList = [];
  List<String> studentRecordDropdownList = [];
  List<int> studentRecordIdList = [];

  void _getUserInfo() {
    profileInfoModel = _authDatabase.getUserInfo()!;
  }


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
      // loadingController.isLoading = false;
      Get.offAndToNamed(Routes.SPLASH);
      loadingController.isLoading = false;
    }
  }
  
  void getStudentRecord() async {

    try{

      final response = await BaseClient().getData(url: InfixApi.getStudentRecord(studentId: GlobalVariableController.studentId!), header: GlobalVariableController.header);

      StudentRecordResponseModel studentRecordResponseModel = StudentRecordResponseModel.fromJson(response);
      if(studentRecordResponseModel.success){
        GlobalVariableController.studentRecordId = studentRecordResponseModel.data.studentRecords.first.id;
        if(studentRecordResponseModel.data.studentRecords.isNotEmpty){
          for(int i = 0; i < studentRecordResponseModel.data.studentRecords.length; i++) {
            studentRecordList.add(studentRecordResponseModel.data.studentRecords[i]);
            studentRecordDropdownList.add('Class ${studentRecordResponseModel.data.studentRecords[i].studentRecordClass} (${studentRecordResponseModel.data.studentRecords[i].section})');
            studentRecordIdList.add(studentRecordResponseModel.data.studentRecords[i].id);
          }
        }
      }

    } catch(e, t){
      debugPrint('$e');
      debugPrint('$t');
    } finally{}
    
  }
  
}
