import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_ui_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../domain/base_client/base_client.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/api_urls.dart';
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

      // var headers = {
      //   'Authorization': GlobalVariableController.token!,
      // };
      // var request = http.Request('POST', Uri.parse('https://spondan.com/infixedu/api/v2/auth/logout'));
      //
      // request.headers.addAll(headers);
      //
      // http.StreamedResponse response = await request.send();
      //
      // if (response.statusCode == 200) {
      //   print('::::::::::::::');
      //   print(await response.stream.bytesToString());
      // }
      // else {
      //   print('falseeeeeee');
      //   print(response.statusCode);
      //   print(response.reasonPhrase);
      // }


      // // loadingController.isLoading = true;
      // // bool result = await _authRepository.signOut();
      //
      // final res = await BaseClient().postData(
      //   url: InfixApi.logout(),
      //   header: {
      //     'Content-Type': 'application/json',
      //     'Authorization': GlobalVariableController.token!,
      //   },
      // );
      //
      // print(res);

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
