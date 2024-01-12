import 'package:flutter_single_getx_api_v2/config/global_variable/app_settings_controller.dart';
import 'package:get/get.dart';

class SecondarySplashController extends GetxController {

  @override
  void onInit() {
    Get.find<AppSettingsController>().getLang();
    super.onInit();
  }

}
