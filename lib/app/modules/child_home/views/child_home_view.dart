import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/icon_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_app_bar/primary_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/child_home_controller.dart';

class ChildHomeView extends GetView<ChildHomeController> {
  const ChildHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0),
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 66,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.appLogo),
                    ),
                  ),
                ),
                const Text(
                  'Welcome to our school',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
        actions: [
          CustomIconButton(
            icon: FontAwesomeIcons.facebookMessenger,
            onPressed: () {
              Get.toNamed(Routes.CHAT);
            },
          ),
          CustomIconButton(
            icon: Icons.exit_to_app,
            onPressed: () {
              Get.dialog(
                CustomPopupDialogue(
                  onYesTap: () {
                    controller.logout();
                  },
                  title: 'Confirmation'.tr,
                  subTitle: AppText.logoutWarningMsg,
                  noText: 'Cancel'.tr,
                  yesText: 'Logout'.tr,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomBackground(
          customWidget: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.homeTileList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CustomCardTile(
                        icon: controller.homeTileList[index].icon,
                        title: controller.homeTileList[index].title,
                        onTap: () {
                          controller.selectIndex.value = index;

                          AppFunctions.routingDecisionForRoleId(
                              roleId: 2,
                              title: controller.homeTileList[index].value);
                        },
                        isSelected: controller.selectIndex.value == index,
                      ),
                    );
                  },
                ),
                40.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
