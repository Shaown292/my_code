import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/language_update.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/localization_controller.dart';
import 'package:flutter_single_getx_api_v2/app/service/language_update/language_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {

  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);
  Get.lazyPut(() => LocalizationController (sharedPreferences: Get.find()));

  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModelUpdate languageModel in LanguageConstants.languages) {
    String jsonStringValues = await rootBundle.loadString('assets/locale/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);


    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value){
      _json[key] = value.toString();
    });

    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;

  }
  return _languages;
}