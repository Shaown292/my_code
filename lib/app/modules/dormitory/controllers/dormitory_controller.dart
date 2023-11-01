import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/dormitory_model/dormitory_response_model.dart';
import '../../../utilities/api_urls.dart';

class DormitoryController extends GetxController {

  LoadingController loadingController = Get.find();
  List<DormitoryData> dormitoryList = [];

  void getDormitoryList() async {
    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.studentDormitory(studentId: GlobalVariableController.studentId!),
        header: GlobalVariableController.header,
      );

      DormitoryResponseModel dormitoryResponseModel = DormitoryResponseModel.fromJson(response);
      if(dormitoryResponseModel.success == true){
        loadingController.isLoading = false;
        if(dormitoryResponseModel.data!.isNotEmpty){
          for(int i = 0; i < dormitoryResponseModel.data!.length; i++) {
            dormitoryList.add(dormitoryResponseModel.data![i]);
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
  }

  @override
  void onInit() {
    if(GlobalVariableController.roleId == 2){
      getDormitoryList();
    }

    super.onInit();
  }

}
