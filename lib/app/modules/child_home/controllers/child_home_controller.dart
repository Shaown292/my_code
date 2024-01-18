import 'package:flutter/foundation.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/database/auth_database.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class ChildHomeController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  HomeController homeController = Get.find();

  List<HomeTileModelClass> homeTileList = studentList;
  final selectIndex = RxInt(-1);
  final AuthDatabase _authDatabase = AuthDatabase.instance;

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


      Get.offNamedUntil('/secondary-splash', (route) => false);
      // Get.offNamedUntil('/splash', (route) => false);

      loadingController.isLoading = false;
    }


    return PostRequestResponseModel();
  }
  @override
  void onInit() {

    homeController.getStudentRecord(studentId: globalRxVariableController.studentId.value!);
    super.onInit();
  }

}
