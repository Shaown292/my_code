import 'package:get/get.dart';

import '../controllers/te_my_routine_controller.dart';

class TeMyRoutineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeMyRoutineController>(
      () => TeMyRoutineController(),
    );
  }
}
