

import 'package:flutter_single_getx_api_v2/app/modules/notification/controller/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
          () => NotificationController(
      ),
    );
  }

}