import 'package:get/get.dart';

import '../controllers/fees_controller.dart';

class FeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FeesController>(
       FeesController(),
    );
  }
}
