import 'package:get/get.dart';

import '../controllers/te_add_content_controller.dart';

class TeAddContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeAddContentController>(
      () => TeAddContentController(),
    );
  }
}
