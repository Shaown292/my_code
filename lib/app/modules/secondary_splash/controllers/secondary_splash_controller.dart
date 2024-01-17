import 'package:flutter_single_getx_api_v2/app/database/auth_database.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/app_settings_controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

class SecondarySplashController extends GetxController {


  @override
  void onInit() async {

    AuthDatabase authDatabase = AuthDatabase.instance;
    await 3000.milliseconds.delay();

    if(authDatabase.auth()){
      Get.find<GlobalRxVariableController>().token.value = authDatabase.getToken()!;
      Get.find<AppSettingsController>().getActiveUserLang();
    } else{
      Get.find<AppSettingsController>().getLang();
    }


    super.onInit();
  }

}
