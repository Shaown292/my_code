import 'package:get/get.dart';

import '../controllers/te_content_list_controller.dart';

class TeContentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeContentListController>(
      () => TeContentListController(),
    );
  }
}
