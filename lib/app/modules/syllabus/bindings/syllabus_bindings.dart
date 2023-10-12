

import 'package:flutter_single_getx_api_v2/app/modules/syllabus/controller/syllabus_controller.dart';
import 'package:get/get.dart';

class SyllabusBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SyllabusController>(
          () => SyllabusController(),
    );
  }

}