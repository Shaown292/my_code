import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
