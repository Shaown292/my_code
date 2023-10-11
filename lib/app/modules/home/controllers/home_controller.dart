import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_ui_model.dart';
import 'package:get/get.dart';

import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';

class HomeController extends GetxController {

  late ProfileInfoModel profileInfoModel;
  final AuthDatabase _authDatabase = AuthDatabase.instance;

  void _getUserInfo() {
    profileInfoModel = _authDatabase.getUserInfo()!;
  }

  void logout() async {
    LoadingController loadingController = Get.find();
    try {
      loadingController.isLoading = true;
      // bool result = await _authRepository.signOut();
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    } finally {
      await _authDatabase.logOut();
      loadingController.isLoading = false;
      Get.offAndToNamed(Routes.SPLASH);
      loadingController.isLoading = false;
    }
  }
}
