import 'package:get/get.dart';

import '../controllers/te_library_controller.dart';

class TeLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeLibraryController>(
      () => TeLibraryController(),
    );
  }
}
