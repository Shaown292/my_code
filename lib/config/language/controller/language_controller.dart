import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/ar.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/en_US.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/iw_IL.dart';
import 'package:get/get.dart';

import 'language_selection.dart';
//......
//**:: ADD/REMOVE LANGUAGE
//.....
String? language;
bool langValue = false;
class LanguageController extends GetxController implements Translations {
  // ignore: prefer_typing_uninitialized_variables
  var appLocale;

  RxString langName = "".obs;

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'ar': ar,
    'iw_IL': iw_IL,
    //......
    //**:: ADD/REMOVE LANGUAGE
    //.....
  };

  Future changeLanguage() async {

    for(int i = 0; i < languages.length; i++){

      if(languages[i].languageValue == language){
        LanguageSelection.instance.val.value = languages[i].languageValue;
        LanguageSelection.instance.drop.value = languages[i].languageValue;
        LanguageSelection.instance.langName = languages[i].languageText;
        appLocale = languages[i].languageValue;
      } else{
          appLocale = Get.deviceLocale?.languageCode;
          langValue = true;
      }

    }

    // if (language == 'en_US') {
    //   LanguageSelection.instance.val.value = 'en_US';
    //   LanguageSelection.instance.drop.value = 'en_US';
    //   LanguageSelection.instance.langName = 'English';
    //   appLocale = 'en_US';
    // } else if (language == 'ar') {
    //   LanguageSelection.instance.val.value = 'ar';
    //   LanguageSelection.instance.drop.value = 'ar';
    //   LanguageSelection.instance.langName = 'العربية';
    //   appLocale = 'ar';
    // } else if (language == 'iw_IL') {
    //   LanguageSelection.instance.val.value = 'iw_IL';
    //   LanguageSelection.instance.drop.value = 'iw_IL';
    //   LanguageSelection.instance.langName = 'עברית';
    //   appLocale = 'iw_IL';
    // }
    // //......
    // //**:: ADD/REMOVE LANGUAGE
    // //.....
    // else {
    //   appLocale = Get.deviceLocale?.languageCode;
    //   langValue = true;
    // }
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
    languageValue: 'en_US',
  ),
  LanguageModel(
    languageText: 'العربية',
    languageValue: 'ar',
  ),
  LanguageModel(
    languageText : 'עברית',
    languageValue: 'iw_IL',
  ),
  //......
  //**:: ADD/REMOVE LANGUAGE
  //.....
];
