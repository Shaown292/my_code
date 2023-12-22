import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/language_update.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/message.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'config/language/controller/language_controller.dart';
import 'config/language/controller/language_selection.dart';
import 'initializer.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/dependency_inj.dart' as dep;

void main() async {
  await Initializer.init();
  Map<String, Map<String, String>> languagesList = await dep.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: language == null ? Get.deviceLocale : Locale(language!),
      translations: LanguageController(),
      fallbackLocale: language != null ? Locale(language!) : const Locale('en_US'),
      // translations: Messages(languages: languagesList),
      // fallbackLocale: Locale(LanguageConstants.languages[0].languageCode,
      //     LanguageConstants.languages[0].countryCode),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
