import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/settings/views/widget/language_bottom_sheet.dart';
import 'package:flutter_single_getx_api_v2/app/modules/settings/views/widget/settings_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
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
                onTileTap: () {
                  controller.showLanguageBottomSheet();
                },
              ),
              10.verticalSpacing,
              SettingsTile(
                icon: ImagePath.changePassword,
                title: "Change Password",
                isLanguage: false,
                onTileTap: () {
                  Get.toNamed(Routes.CHANGE_PASSWORD);
                },
              ),
              10.verticalSpacing,
              SettingsTile(
                icon: ImagePath.delete,
                title: "Delete Account",
                isLanguage: false,
                color: Colors.redAccent,
                onTileTap: () {
                  Get.dialog(
                      const AccountDeleteDialogue(
                        title: "Confirmation",
                    subTitle: AppText.deleteAccountWarning,
                    noText: 'No',
                    yesText: 'Yes',
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
