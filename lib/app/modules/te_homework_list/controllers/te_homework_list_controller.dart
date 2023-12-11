import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher/teacher_homework_model/teacher_homework_list_response_model.dart';
import 'package:get/get.dart';

class TeHomeworkListController extends GetxController {

  LoadingController loadingController = Get.find();

  RxList<TeacherHomeworkData> teacherHomeworkList = <TeacherHomeworkData>[].obs;


  Future<TeacherHomeworkListResponseModel> getTeacherHomeWorkList() async {

    try{

      teacherHomeworkList.clear();
      loadingController.isLoading = true;
      final response = await BaseClient().getData(url: InfixApi.getTeacherHomeworkList, header: GlobalVariable.header,);

      TeacherHomeworkListResponseModel teacherHomeworkListResponseModel = TeacherHomeworkListResponseModel.fromJson(response);

      if(teacherHomeworkListResponseModel.success == true){
        loadingController.isLoading = false;
        if(teacherHomeworkListResponseModel.data!.isNotEmpty){
          for (var element in teacherHomeworkListResponseModel.data!) {teacherHomeworkList.add(element);}
        }
      } else{
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: teacherHomeworkListResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');

    } finally{
      loadingController.isLoading = false;
    }

    return TeacherHomeworkListResponseModel();
  }


  @override
  void onInit() {
    getTeacherHomeWorkList();
    super.onInit();
  }

}
