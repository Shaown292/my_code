import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/about/about_response_model.dart';
import 'package:get/get.dart';

class AboutController extends GetxController {
  LoadingController loadingController = Get.find();

  AboutData? aboutInformation;

  Future<AboutResponseModel> getAboutInformation() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(url: InfixApi.getTeacherAbout, header: GlobalVariable.header);

      AboutResponseModel aboutResponseModel = AboutResponseModel.fromJson(response);

      if(aboutResponseModel.status == true){
        loadingController.isLoading = false;
        aboutInformation = aboutResponseModel.data;

      } else{
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: aboutResponseModel.message ?? AppText.somethingWentWrong,);
      }

    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AboutResponseModel();
  }

  @override
  void onInit() {
    getAboutInformation();
    super.onInit();
  }

}
