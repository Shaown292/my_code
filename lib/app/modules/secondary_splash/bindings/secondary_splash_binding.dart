import 'package:get/get.dart';

import '../controllers/secondary_splash_controller.dart';

class SecondarySplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondarySplashController>(
      () => SecondarySplashController(),
    );
  }
}
