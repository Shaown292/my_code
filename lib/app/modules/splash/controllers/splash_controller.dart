import 'package:flutter/animation.dart';
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
    await 3000.milliseconds.delay();
    // Get.offAndToNamed(Routes.SECONDARY_SPLASH);
    AuthDatabase authDatabase = AuthDatabase.instance;
    if (authDatabase.auth()) {
      Get.offAndToNamed(Routes.HOME);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}
