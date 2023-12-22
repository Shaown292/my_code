import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/language_update.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/language_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(LanguageConstants.languages[0].languageCode,
      LanguageConstants.languages[0].countryCode);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  List<LanguageModelUpdate> _languages = [];
  Locale get locale => _locale;
  List<LanguageModelUpdate> get languages => _languages;


  void loadCurrentLanguage() {
    _locale = Locale(sharedPreferences.getString(LanguageConstants.LANGUAGE_CODE) ??
        LanguageConstants.languages[0].languageCode,
        sharedPreferences.getString(LanguageConstants.COUNTRY_CODE) ??
            LanguageConstants.languages[0].countryCode);

    for (int index = 0; index < LanguageConstants.languages.length; index++) {
      if (LanguageConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(LanguageConstants.languages);
    update();
  }



  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        LanguageConstants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(LanguageConstants.COUNTRY_CODE, locale.countryCode!);
  }


}