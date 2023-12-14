import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/icon_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_app_bar/primary_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      leadingIcon: const SizedBox(),
      appBar: Obx(() => PrimaryAppBar(
        title: controller.globalRxVariableController.roleId.value == 1
            ? 'Welcome to Admin'
            : 'Welcome to our school',
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
                  title: 'Confirmation',
                  subTitle: AppText.logoutWarningMsg,
                  noText: 'cancel',
                  yesText: 'logout',
                ),
              );
            },
          ),
        ],
      ),),
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
                              roleId: controller.globalRxVariableController.roleId.value!,
                              title: controller.homeTileList[index].value);

                          // controller.selectIndex.value = index;
                          // AppFunctions.getStudentDashboardNavigation(
                          //     title: list[index].value);
                          // AppFunctions.getAdminHomeNavigation(
                          //     title: list[index].value);
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
