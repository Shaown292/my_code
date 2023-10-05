import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'config/language/controller/language_controller.dart';
import 'config/language/controller/language_selection.dart';

void main() {
  runApp(
    GetMaterialApp(
      locale: langValue ? Get.deviceLocale : Locale(LanguageSelection.instance.val),
      translations: LanguageController(),
      fallbackLocale: Locale('en'),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
