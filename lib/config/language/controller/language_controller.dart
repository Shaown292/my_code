import 'package:flutter_single_getx_api_v2/config/language/controller/languages/translated_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/en_US.dart';
import 'package:get/get.dart';

import 'language_selection.dart';

String? language;
bool langValue = false;

class LanguageController extends GetxController implements Translations {
  String appLocale = 'en';

  RxString langName = "".obs;
  Map<String, Map<String, String>> translationsData = {
    "en": en,
    "bn": translatedLanguage,
  };

  @override
  Map<String, Map<String, String>> get keys => translationsData;

  Future changeLanguage() async {
    for (int i = 0; i < languageList.length; i++) {
      if (languageList[i].languageLocal == language) {
        LanguageSelection.instance.val.value = languageList[i].languageLocal;
        LanguageSelection.instance.drop.value = languageList[i].languageLocal;
        LanguageSelection.instance.langName = languageList[i].languageName;
        appLocale = languageList[i].languageLocal;
      } else {
        appLocale = Get.deviceLocale!.languageCode;
        langValue = true;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    keys['en'] = en;
    await changeLanguage();
    Get.updateLocale(Locale(appLocale));
    update();
  }
}

class LanguageModel {
  final int id;
  final String languageName;
  final String languageLocal;
  final bool activeStatus;

  LanguageModel(
      {required this.id,
      required this.languageName,
      required this.languageLocal,
      required this.activeStatus});
}

RxList<LanguageModel> languageList = <LanguageModel>[].obs;
