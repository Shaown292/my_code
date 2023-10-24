import 'package:get/get.dart';

import '../controllers/active_exam_controller.dart';

class ActiveExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveExamController>(
      () => ActiveExamController(),
    );
  }
}
