import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'config/language/controller/language_controller.dart';
import 'initializer.dart';
// import 'package:flutter_single_getx_api_v2/app/service/language_update/dependency_inj.dart' as dep;

void main() async {
  await Initializer.init();
  // Map<String, Map<String, String>> languagesList = await dep.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.ltr,
      locale: language == null ? Get.deviceLocale : Locale(language!),
      translations: LanguageController(),
      fallbackLocale: language != null ? Locale(language!) : const Locale('en'),
      // translations: Messages(languages: languagesList),
      // fallbackLocale: Locale(LanguageConstants.languages[0].languageCode,
      //     LanguageConstants.languages[0].countryCode),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
