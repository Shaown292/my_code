import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_selection.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/languages/amar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_divider.dart';

class SettingsController extends GetxController{

  // LocalizationController localizationController = Get.find();

  LanguageController languageController = Get.find();

  // String? appLocale;
  // var langName = "".obs;

  // Map<String, Map<String, String>> get keys => {
  //   'en': enLang,
  //   'bn': enLang,
  //   //......
  //   //**:: ADD/REMOVE LANGUAGE
  //   //.....
  // };
  //
  // Future changeLanguage() async {
  //   print('calling changes');
  //   if (language == 'en') {
  //     LanguageSelection.instance.val = 'en';
  //     LanguageSelection.instance.drop = 'en';
  //     LanguageSelection.instance.langName = 'English';
  //     appLocale = 'en';
  //   } else if (language == 'bn') {
  //     LanguageSelection.instance.val = 'bn';
  //     LanguageSelection.instance.drop = 'bn';
  //     LanguageSelection.instance.langName = 'বাংলা';
  //     appLocale = 'bn';
  //   }
  //   //......
  //   //**:: ADD/REMOVE LANGUAGE
  //   //.....
  //   else {
  //     appLocale = Get.deviceLocale?.languageCode;
  //     langValue = true;
  //   }
  //   langName.value = LanguageSelection.instance.langName;
  // }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   // await changeLanguage();
  //   // Get.updateLocale(Locale(appLocale!));
  //   // update();
  // }


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
                // itemCount: localizationController.languages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {

                      // log('${languageController.keys.keys}');
                      // languageController.keys.forEach((key, value) {print('${key} :: $value \n\n\n');});

                      //
                      // debugPrint("Selected Language :::::::::::${languageList[index].languageLocal} ::: ${languageList[index].languageName}");
                      // LanguageSelection.instance.drop.value = languageList[index].languageLocal;
                      // final sharedPref = await SharedPreferences.getInstance();
                      // sharedPref.setString('language', languageList[index].languageLocal);
                      // sharedPref.setString('language_name', languageList[index].languageName);
                      //
                      //
                       languageController.appLocale = languageList[index].languageLocal;

                       print('From Setting ::: ${languageController.appLocale}');
                       log('${languageController.translationsData[languageController.appLocale]}');



                      Get.updateLocale(Locale(languageController.appLocale));




                      //
                      // print('Selected lang ::: ${languageController.keys[languageController.appLocale]}');
                      //
                      //
                      // LanguageSelection.instance.drop.value = languageList[index].languageLocal;
                      //
                      // for (var element in languageList) {
                      //   if (element.languageLocal == languageList[index].languageLocal) {
                      //     print("Elements :::: ${element.languageLocal}");
                      //     print('Values ::::: ${element.languageLocal} :: ${languageList[index].languageLocal}');
                      //     LanguageSelection.instance.langName =
                      //         element.languageName;
                      //   }
                      // }
                      // //languageController.langName.value = LanguageSelection.instance.langName;
                      // languageController.update();
                      // print('Lang name ::: ${languageController.langName}');
                      // log('Lang Keys ::: ${languageController.keys}');


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
