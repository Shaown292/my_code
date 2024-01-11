import 'dart:convert';
import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/amar.dart';
import 'package:get/get.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';
import 'package:http/http.dart' as http;

class SplashController extends GetxController with GetTickerProviderStateMixin {
  GlobalRxVariableController globalRxVariableController = Get.find();

  @override
  void onInit() {
    // getLang();
    _animation();
    navNextPage();
    super.onInit();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Animation? animation;
  AnimationController? animationController;

  _animation() {
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 60.0, end: 120.0).animate(animationController!);
    animationController?.forward();
  }

  void navNextPage() async {
    AuthDatabase authDatabase = AuthDatabase.instance;
    await 4000.milliseconds.delay();

    if (authDatabase.auth()) {
      globalRxVariableController.roleId.value =
          authDatabase.getUserInfo()!.data.user.roleId;
      globalRxVariableController.notificationCount.value =
          authDatabase.getUnReadNotification() ?? 0;
      globalRxVariableController.token.value = authDatabase.getToken()!;
      globalRxVariableController.userId.value =
          authDatabase.getUserInfo()!.data.user.id;
      globalRxVariableController.roleId.value =
          authDatabase.getUserInfo()!.data.user.roleId;
      globalRxVariableController.email.value =
          authDatabase.getUserInfo()!.data.user.email;
      AppFunctions().getFunctions(globalRxVariableController.roleId.value!);

      if (authDatabase.getUserInfo()!.data.user.roleId == 2) {
        globalRxVariableController.studentId.value =
            authDatabase.getUserInfo()!.data.user.studentId;
        globalRxVariableController.isStudent.value = true;
        debugPrint('Student Id ::: ${globalRxVariableController.studentId}');
      }

      if (authDatabase.getUserInfo()!.data.user.roleId == 3) {
        globalRxVariableController.parentId.value =
            authDatabase.getUserInfo()!.data.user.parentId;
        debugPrint('Parent Id ::: ${globalRxVariableController.parentId}');
      }

      if (authDatabase.getUserInfo()!.data.user.roleId == 1 ||
          authDatabase.getUserInfo()!.data.user.roleId == 4) {
        globalRxVariableController.staffId.value =
            authDatabase.getUserInfo()!.data.user.staffId;
        debugPrint(
            'Admin/Teacher Id ::: ${globalRxVariableController.staffId}');
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  // void getLang() async {
  //   String url = 'https://spondan.com/infixedu/api/v2/lang';
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     print('Response ::: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       // Parse the response and return the translations
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       Map<String, String> translations = Map<String, String>.from(responseData['lang']);
  //       // languageList = responseData['lang_list'];
  //       print('Response Data ::: ${responseData['lang_list'][0]['lang_name']}');
  //       // print('object ::: ${responseData['lang_list'].length}');
  //
  //
  //       for(int i = 0; i < responseData['lang_list'].length; i++){
  //         languageList.add(LanguageModel(
  //           id: responseData['lang_list'][i]['id'],
  //           languageName: responseData['lang_list'][i]['lang_name'],
  //           languageLocal: responseData['lang_list'][i]['locale'],
  //           activeStatus: responseData['lang_list'][i]['active_status'],
  //         ));
  //         // Get.find<LanguageController>().keys.assignAll({responseData['lang_list'][i]['locale']: translations});
  //
  //         if(responseData['lang_list'][i]['active_status'] == 1){
  //           Get.find<LanguageController>().setLanguage(translations, responseData['lang_list'][i]['locale']);
  //           Get.find<LanguageController>().keys[responseData['lang_list'][i]['locale']] = translations;
  //           Get.find<LanguageController>().keys.update('en', (value) => translations);
  //         }
  //
  //
  //         log('${Get.find<LanguageController>().keys.keys}');
  //
  //         print('Response Data ::: ${languageList[i].languageName}');
  //       }
  //
  //
  //       // amar = translations;
  //       print('trans ::: $translations');
  //
  //
  //     } else {
  //       throw Exception('Failed to load translations');
  //     }
  //   } catch (e, t) {
  //     print(e);
  //     print(t);
  //     throw Exception('Failed to load translations: $e');
  //   }
  // }

}
