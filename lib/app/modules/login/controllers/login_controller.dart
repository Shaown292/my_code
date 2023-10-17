import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_ui_model.dart';
import 'package:get/get.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/widgets/no_internet/InternetController.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class LoginController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isObscureText = true.obs;
  GlobalVariableController globalVariableController = Get.put(GlobalVariableController());

  void userLogin({required String email, required String password}) async {
    ProfileInfoModel profileInfoModel;

    try {
      final res = await BaseClient().postData(
        url: InfixApi.login(),
        header: {'Content-Type': 'application/json'},
        payload: {
          "email": email,
          "password": password
        },
      );

      profileInfoModel = ProfileInfoModel.fromJson(res);
      if (profileInfoModel.success == true) {
        isLoading.value = false;
        GlobalVariableController.notificationCount = profileInfoModel.data.unreadNotifications;
        showBasicSuccessSnackBar(message: profileInfoModel.message);
        bool status = await AuthDatabase.instance.saveAuthInfo(
          profileInfoModelModel: profileInfoModel,
        );

        if (status) {
          AppFunctions().getFunctions(profileInfoModel.data.user.roleId);
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: profileInfoModel.message);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void demoUserLogin({required int role}) async {
    ProfileInfoModel profileInfoModel;
    try {

      final response = await BaseClient().getData(
        url: InfixApi.demoLogin(role.toString()),
        header: {'Content-Type': 'application/json'},
      );

      profileInfoModel = ProfileInfoModel.fromJson(response);
      if (profileInfoModel.success == true) {
        isLoading.value = false;
        GlobalVariableController.notificationCount = profileInfoModel.data.unreadNotifications;
        showBasicSuccessSnackBar(message: profileInfoModel.message);
        bool status = await AuthDatabase.instance.saveAuthInfo(
          profileInfoModelModel: profileInfoModel,
        );

        if (status) {
          AppFunctions().getFunctions(profileInfoModel.data.user.roleId);
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: profileInfoModel.message);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    internetConnectionChecker();
    super.onInit();
  }
}
