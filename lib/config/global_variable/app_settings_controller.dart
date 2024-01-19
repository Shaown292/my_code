import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/translated_language.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppSettingsController extends GetxController {
  RxBool languageLoader = false.obs;

  void navNextPage() async {
    await 1000.milliseconds.delay();

    Get.offAndToNamed(Routes.SPLASH);
  }

  void getLang() async {
    debugPrint('LANG URL :: ${InfixApi.languageList}');

    try {
      languageList.clear();
      languageLoader.value = false;

      print('Translated DATA $translatedLanguage');
      final response = await http.get(Uri.parse(InfixApi.languageList));

      if (response.statusCode == 200) {
        languageLoader.value = true;
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, String> translations =
            Map<String, String>.from(responseData['lang']);
        for (int i = 0; i < responseData['lang_list'].length; i++) {


          languageList.add(LanguageModel(
            id: responseData['lang_list'][i]['id'],
            languageName: responseData['lang_list'][i]['lang_name'],
            languageLocal: responseData['lang_list'][i]['locale'],
            defaultLocale: responseData['lang_list'][i]['default_locale'],
            activeStatus: responseData['lang_list'][i]['active_status'],
          ));

          if (responseData['lang_list'][i]['active_status'] == true) {
            translatedLanguage.assignAll(translations);
            print('Translated DATA $translatedLanguage');
            Get.find<LanguageController>().langName.value =
                responseData['lang_list'][i]['lang_name'];
            // Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['locale'];
            Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['default_locale'];
            Get.updateLocale(Locale(responseData['lang_list'][i]['locale']));
          }
        }
        navNextPage();
      } else {
        languageLoader.value = true;
        navNextPage();
        throw Exception('Failed to load translations');
      }
    } catch (e, t) {
      languageLoader.value = true;
      navNextPage();
      debugPrint('$e');
      debugPrint('$t');
      throw Exception('Failed to load translations: $e');
    } finally {
      languageLoader.value = true;
      navNextPage();
    }
  }

  void getActiveUserLang() async {
    debugPrint('LANG URL :: ${InfixApi.activeUserLanguageList}');

    try {
      languageList.clear();
      languageLoader.value = false;

      final response = await http.get(Uri.parse(InfixApi.activeUserLanguageList),headers:
      GlobalVariable.header,
      );

      if (response.statusCode == 200) {
        languageLoader.value = true;
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, String> translations =
        Map<String, String>.from(responseData['lang']);
        for (int i = 0; i < responseData['lang_list'].length; i++) {


          languageList.add(LanguageModel(
            id: responseData['lang_list'][i]['id'],
            languageName: responseData['lang_list'][i]['lang_name'],
            languageLocal: responseData['lang_list'][i]['locale'],
            defaultLocale: responseData['lang_list'][i]['default_locale'],
            activeStatus: responseData['lang_list'][i]['active_status'],
          ));

          if (responseData['lang_list'][i]['active_status'] == true) {
            translatedLanguage.assignAll(translations);
            Get.find<LanguageController>().langName.value =
            responseData['lang_list'][i]['lang_name'];
            // Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['locale'];
            Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['default_locale'];
            Get.updateLocale(Locale(Get.find<LanguageController>().appLocale));
          }
        }
        navNextPage();
      } else {
        languageLoader.value = true;
        navNextPage();
        // throw Exception('Failed to load translations');
      }
    } catch (e, t) {
      languageLoader.value = true;
      navNextPage();
      debugPrint('$e');
      debugPrint('$t');
      // throw Exception('Failed to load translations: $e');
    } finally {
      languageLoader.value = true;
      navNextPage();
    }
  }


}
