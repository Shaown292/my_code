import 'package:get/get.dart';

import '../controllers/te_content_controller.dart';

class TeContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeContentController>(
      () => TeContentController(),
    );
  }
}
