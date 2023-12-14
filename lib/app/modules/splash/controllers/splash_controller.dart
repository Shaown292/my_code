import 'package:flutter/animation.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin{

  GlobalRxVariableController globalRxVariableController = Get.find();

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
    await 4000.milliseconds.delay();

    if (authDatabase.auth()) {
      globalRxVariableController.roleId.value = authDatabase.getUserInfo()!.data.user.roleId;
      globalRxVariableController.notificationCount.value = authDatabase.getUnReadNotification() ?? 0;
      globalRxVariableController.token.value = authDatabase.getToken()!;
      globalRxVariableController.userId.value = authDatabase.getUserInfo()!.data.user.id;
      globalRxVariableController.roleId.value = authDatabase.getUserInfo()!.data.user.roleId;
      AppFunctions().getFunctions(globalRxVariableController.roleId.value!);
      if(authDatabase.getUserInfo()!.data.user.roleId == 2){
        globalRxVariableController.studentId.value = authDatabase.getUserInfo()!.data.user.studentId;
      }

    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

}
