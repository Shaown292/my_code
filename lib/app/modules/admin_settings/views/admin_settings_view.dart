import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/settings/views/widget/settings_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_settings_controller.dart';

class AdminSettingsView extends GetView<AdminSettingsController> {
  const AdminSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Settings",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              SettingsTile(
                icon: ImagePath.settingLanguage,
                title: "Change Language",
                isLanguage: true,
                onTileTap: (){
                  controller.showLanguageBottomSheet();
                },
              ),
              10.verticalSpacing,
              SettingsTile(
                icon: ImagePath.changePassword,
                title: "Change Password",
                isLanguage: false,
                onTileTap: (){
                  Get.toNamed(Routes.CHANGE_PASSWORD);
                },
              ),

              10.verticalSpacing,
              SettingsTile(
                icon: ImagePath.delete,
                title: "Delete Account",
                isLanguage: false,
                onTileTap: (){
                  Get.dialog(
                    CustomPopupDialogue(
                      onYesTap: () {

                      },
                      title: 'Confirmation',
                      subTitle: AppText.deleteAccountWarningMsg,
                      noText: 'cancel',
                      yesText: 'delete',
                    ),
                  );
                },
              ),
            ],
          ),
        ),

      ),
    );
  }
}
