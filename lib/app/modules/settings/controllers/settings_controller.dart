import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/database/auth_database.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_selection.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/translated_language.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_divider.dart';

class SettingsController extends GetxController {
  LanguageController languageController = Get.find();
  RxBool languageLoader = false.obs;
  RxBool accountDeleteLoader = false.obs;
  final AuthDatabase _authDatabase = AuthDatabase.instance;

  Future<void> updateLanguage({required int langId}) async {
    try {
      languageList.clear();
      languageLoader.value = false;

      final response =
          await http.post(Uri.parse(InfixApi.updateLanguage(langId: langId)),
              body: jsonEncode(
                {
                  'lang_id': langId.toString(),
                },
              ),
              headers: GlobalVariable.header);

      if (response.statusCode == 200) {
        languageLoader.value = true;
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));
        // log('Response ::: ${responseData['lang']['Change Language']}');
        // Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, String> translations =
            Map<String, String>.from(responseData['lang']);
        for (int i = 0; i < responseData['lang_list'].length; i++) {
          languageList.add(LanguageModel(
            id: responseData['lang_list'][i]['id'],
            languageName: responseData['lang_list'][i]['lang_name'],
            languageLocal: responseData['lang_list'][i]['locale'],
            defaultLocale: responseData['lang_list'][i]['default_locale'],
            activeStatus: responseData['lang_list'][i]['active_status'],
          ));

          if (responseData['lang_list'][i]['active_status'] == true) {
            translatedLanguage.assignAll(translations);

            languageController.keys.update('active', (value) => translations);

            log('After Change Lange ::: $translatedLanguage');

            Get.find<LanguageController>().langName.value =
                responseData['lang_list'][i]['lang_name'];
            // Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['locale'];
            Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['default_locale'];
            print('Local ::: ${Get.find<LanguageController>().appLocale}');
            Get.updateLocale(Locale(Get.find<LanguageController>().appLocale));

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isRtl', responseData['lang_list'][i]['rtl']);
            Get.find<GlobalRxVariableController>().isRtl.value = responseData['lang_list'][i]['rtl'];
            print('Is RTL ::: ${Get.find<GlobalRxVariableController>().isRtl}');
          }
        }
      } else {
        languageLoader.value = true;
        throw Exception('Failed to load translations');
      }
    } catch (e, t) {
      languageLoader.value = true;
      debugPrint('$e');
      debugPrint('$t');
      throw Exception('Failed to load translations: $e');
    } finally {
      languageLoader.value = true;
    }
  }

  Future<PostRequestResponseModel> deleteAccount() async {

    try{
      accountDeleteLoader.value = true;
      
      final response = await BaseClient().postData(url: InfixApi.accountDelete, header: GlobalVariable.header, payload: {
        'id': Get.find<GlobalRxVariableController>().userId.value.toString(),
      });

      PostRequestResponseModel responseModel = PostRequestResponseModel.fromJson(response);

      if(responseModel.success == true){
        accountDeleteLoader.value = false;

        await _authDatabase.logOut();

        Get.offNamedUntil('/secondary-splash', (route) => false);


      } else{
        accountDeleteLoader.value = false;
        showBasicFailedSnackBar(message: responseModel.message ?? AppText.somethingWentWrong,);
      }
      
    }catch(e, t){
      accountDeleteLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    }finally{
      accountDeleteLoader.value = false;
    }

    return PostRequestResponseModel();
  }

  void showLanguageBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height * 0.4,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.verticalSpacing,
          const CustomDivider(
            height: 3,
            width: 30,
          ),
          30.verticalSpacing,
          Expanded(
            child: ListView.builder(
                itemCount: languageList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      updateLanguage(langId: languageList[index].id)
                          .then((value) async {
                        LanguageSelection.instance.drop.value =
                            languageList[index].languageLocal;
                        final sharedPref =
                            await SharedPreferences.getInstance();
                        sharedPref.setString(
                            'language', languageList[index].languageLocal);
                        sharedPref.setString(
                            'language_name', languageList[index].languageName);
                        languageController.appLocale =
                            languageList[index].languageLocal;

                        Get.updateLocale(Locale(languageController.appLocale));

                        LanguageSelection.instance.drop.value =
                            languageList[index].languageLocal;

                        for (var element in languageList) {
                          if (element.languageLocal ==
                              languageList[index].languageLocal) {
                            LanguageSelection.instance.langName =
                                element.languageName;
                          }
                        }
                        languageController.langName.value =
                            LanguageSelection.instance.langName;
                      });
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width,
                      color: index % 2 == 0
                          ? AppColors.profileCardTextColor
                          : Colors.white,
                      child: Center(
                        child: Text(
                          languageList[index].languageName,
                          style: AppTextStyle.blackFontSize14W400,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }


}
