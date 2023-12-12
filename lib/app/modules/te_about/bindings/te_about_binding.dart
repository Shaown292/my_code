import 'package:get/get.dart';

import '../controllers/te_about_controller.dart';

class TeAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeAboutController>(
      () => TeAboutController(),
    );
  }
}
