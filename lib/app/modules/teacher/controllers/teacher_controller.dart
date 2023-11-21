import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/teacher_response_model/teacher_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';
import '../../home/controllers/home_controller.dart';

class TeacherController extends GetxController {

  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();
  final selectIndex = RxInt(0);
  List<TeacherData> teacherList = [];



  Future<TeacherResponseModel?> getAllTeacherList({required int recordId}) async {

    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentTeacherList(recordId),
        header: GlobalVariable.header,
      );

      TeacherResponseModel teacherResponseModel = TeacherResponseModel.fromJson(response);
      if(teacherResponseModel.success == true){
        loadingController.isLoading = false;
        if(teacherResponseModel.data!.isNotEmpty){
          for(int i = 0; i < teacherResponseModel.data!.length; i++) {
            teacherList.add(teacherResponseModel.data![i]);
          }

        }
      }

    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return TeacherResponseModel();
  }

  @override
  void onInit() {
    if (homeController.studentRecordList.isNotEmpty) {
      getAllTeacherList(recordId: homeController.studentRecordList[0].id);
    }
    super.onInit();
  }
}
