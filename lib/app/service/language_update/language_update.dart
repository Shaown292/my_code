// ignore_for_file: constant_identifier_names

import 'package:flutter_single_getx_api_v2/app/service/language_update/language_model.dart';

class LanguageConstants{

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModelUpdate> languages = [
    LanguageModelUpdate(languageName: 'English',
      countryCode: 'US', languageCode: 'en',),
    LanguageModelUpdate(languageName: 'Urdu',
      countryCode: 'PK', languageCode: 'ur',),
  ];

}