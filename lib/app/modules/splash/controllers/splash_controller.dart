import 'package:flutter/animation.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/controllers/notification_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin{
  @override
  void onInit() {
    _animation();
    navNextPage();
    super.onInit();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Animation? animation;
  AnimationController? animationController;

  _animation(){
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 60.0, end: 120.0).animate(animationController!);
    animationController?.forward();
  }

  void navNextPage() async {
    AuthDatabase authDatabase = AuthDatabase.instance;
    await 3000.milliseconds.delay();

    if (authDatabase.auth()) {
      GlobalVariableController.roleId = authDatabase.getUserInfo()!.data.user.roleId;
      GlobalVariableController.notificationCount = authDatabase.getUnReadNotification() ?? 0;
      GlobalVariableController.token = authDatabase.getToken();
      AppFunctions().getFunctions(GlobalVariableController.roleId!);

    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

}
