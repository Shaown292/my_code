import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/icon_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_app_bar/primary_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    List<HomeTileModelClass> list = data["homeListTile"];

    return InfixEduScaffold(
      appBar: PrimaryAppBar(
        title: 'Welcome to our school',
        actions: [
          CustomIconButton(
            icon: FontAwesomeIcons.facebookMessenger,
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
          ),
          CustomIconButton(
            icon: Icons.exit_to_app,
            onPressed: () {
              Get.dialog(
                AccountDeleteDialogue(
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
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Obx(() => CustomCardTile(
                      icon: list[index].icon,
                      title: list[index].title,
                      onTap: () {
                        controller.selectIndex.value = index;
                        AppFunctions.getStudentDashboardNavigation(title: list[index].value);
                        // Get.toNamed(
                        //   Routes.HOMEWORK,
                        // );
                      },
                      isSelected: controller.selectIndex.value == index,
                    ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
