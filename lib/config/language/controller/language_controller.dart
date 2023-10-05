import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/bn.dart';
import 'package:get/get.dart';

import 'language_selection.dart';
//......
//**:: ADD/REMOVE LANGUAGE
//.....
var language;
bool langValue = false;
class LanguageController extends GetxController implements Translations {

  var appLocale;
  var langName = "".obs;

  @override
  Map<String, Map<String, String>> get keys => {
    'en': enLang,
    'bn': enLang,
    //......
    //**:: ADD/REMOVE LANGUAGE
    //.....
  };

  Future changeLanguage() async {
    if (language == 'en') {
      LanguageSelection.instance.val = 'en';
      LanguageSelection.instance.drop = 'en';
      LanguageSelection.instance.langName = 'English';
      appLocale = 'en';
    } else if (language == 'bn') {
      LanguageSelection.instance.val = 'bn';
      LanguageSelection.instance.drop = 'bn';
      LanguageSelection.instance.langName = 'বাংলা';
      appLocale = 'bn';
    }
    //......
    //**:: ADD/REMOVE LANGUAGE
    //.....
    else {
      appLocale = Get.deviceLocale?.languageCode;
      langValue = true;
    }
    langName.value = LanguageSelection.instance.langName;
  }

  @override
  void onInit() async {
    super.onInit();
    await changeLanguage();
    Get.updateLocale(Locale(appLocale));
    update();
  }
}

class LanguageModel {
  final String languageText;
  final String languageValue;

  LanguageModel({required this.languageText, required this.languageValue});
}

final List<LanguageModel> languages = [
  LanguageModel(
    languageText: 'English',
    languageValue: 'en',
  ),
  LanguageModel(
    languageText: 'বাংলা',
    languageValue: 'bn',
  ),
  //......
  //**:: ADD/REMOVE LANGUAGE
  //.....
];
