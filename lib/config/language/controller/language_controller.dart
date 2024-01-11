import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/amar.dart';
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
  Map<String, Map<String, String>> translationsData = {
    "en": en,
    "amar": amar,
    'bn': {
      "test": 'Test data'
    }
  };


  // RxMap<String, Map<String, String>> translationsData = {
  //   "en" : en,
  //   "amar" : amar,
  // }.obs;

  @override
  Map<String, Map<String, String>> get keys => translationsData;

  void setLanguage(Map<String, String> map, keysValue){

    print('Key ::: $keysValue');
    keys.assign(keysValue, map);
   // keys.assign('en', map);

    //keys[keysValue] = map;

    log('Key :::::::::::::::::::::: ${keys}');


    // keys.updateAll((key, value) => keysValue);
    // key.rem

  }

  Future changeLanguage() async {

    for(int i = 0; i < languageList.length; i++){
      print('Before Change Language ::: ${languageList[i].languageLocal} ::: ${language}');
      if(languageList[i].languageLocal == language){
        print('Change Language ::: ${languageList[i].languageLocal} ::: ${language}');
        LanguageSelection.instance.val.value = languageList[i].languageLocal;
        LanguageSelection.instance.drop.value = languageList[i].languageLocal;
        LanguageSelection.instance.langName = languageList[i].languageName;
        appLocale = languageList[i].languageLocal;
        print('App Local ::: $appLocale');
      } else{
          appLocale = Get.deviceLocale!.languageCode;
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
    //langName.value = LanguageSelection.instance.langName;
  }

  void getLang() async {
    String url = 'https://spondan.com/infixedu/api/v2/lang';

    try {
      final response = await http.get(Uri.parse(url));
      print('Response ::: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, String> translations = Map<String, String>.from(responseData['lang']);
        // Map<String, String> translations = Map<String, String>.from(responseData['lang']);
        print('Response Data ::: ${responseData['lang_list'][0]['lang_name']}');

        for (int i = 0; i < responseData['lang_list'].length; i++) {
          languageList.add(LanguageModel(
            id: responseData['lang_list'][i]['id'],
            languageName: responseData['lang_list'][i]['lang_name'],
            languageLocal: responseData['lang_list'][i]['locale'],
            activeStatus: responseData['lang_list'][i]['active_status'],
          ));

          if (responseData['lang_list'][i]['active_status'] == true) {


            log("translationsData :::: ${keys['bn']}");

            // keys[responseData['lang_list'][i]['locale']] = translationsData;
            keys.update('bn', (value) => translations);
            

            log("translationsData :::: ${keys['bn']}");

          }

        }
      } else {
        throw Exception('Failed to load translations');
      }
    } catch (e, t) {
      print(e);
      print(t);
      throw Exception('Failed to load translations: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    keys['en'] = en;
    getLang();
    // await changeLanguage();
    // Get.updateLocale(Locale(appLocale));
    update();
  }
}

class LanguageModel {
  final int id;
  final String languageName;
  final String languageLocal;
  final bool activeStatus;

  LanguageModel({required this.id, required this.languageName, required this.languageLocal, required this.activeStatus});
}

 RxList<LanguageModel> languageList = <LanguageModel>[
   LanguageModel(id: 10, languageName: 'amar', languageLocal: 'amar', activeStatus: false)
 ].obs;
