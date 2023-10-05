import 'package:get/get.dart';

import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    print('init calling');
    navNextPage();
    super.onInit();
  }

  void navNextPage() async {
    await 900.milliseconds.delay();
    AuthDatabase authDatabase = AuthDatabase.instance;
    if (authDatabase.auth()) {
      Get.offAndToNamed(Routes.HOME);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
