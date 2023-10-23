import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/modules/settings/views/widget/language_bottom_sheet.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  List<String> languageList = [
    "English",
    "Bangla",
    "Hindi",
    "German",
  ];
  void showLanguageBottomSheet () {
    Get.bottomSheet(
       LanguageBottomSheet(
         languageList: languageList,
         languageCount: languageList.length,
         onLanguageTap: ()=> debugPrint("Tapped"),
      )
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
