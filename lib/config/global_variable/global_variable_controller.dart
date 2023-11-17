
import 'package:get/get.dart';

import '../../app/data/module_data/home_data/home_dummy_data.dart';


class GlobalVariableController {

 static List<HomeTileModelClass> homeTileList = [];
 static int? roleId;
 static String? token;
 static int notificationCount = 0;
 static int? studentRecordId;
 static int? studentId;
 static int? userId;

 static Map<String, String> header = {
 'Content-Type': 'application/json',
 'Accept': 'application/json',
 'Authorization': GlobalVariableController.token!,
 };

}

class NotificationCountController extends GetxController{
 RxInt notificationCount = 0.obs;
}

NotificationCountController notificationCountController = Get.put(NotificationCountController());