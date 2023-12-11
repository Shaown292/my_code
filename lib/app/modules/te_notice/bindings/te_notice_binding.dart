import 'package:get/get.dart';

import '../controllers/te_notice_controller.dart';

class TeNoticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeNoticeController>(
      () => TeNoticeController(),
    );
  }
}
