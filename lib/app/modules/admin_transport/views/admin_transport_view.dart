import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_transport_controller.dart';

class AdminTransportView extends GetView<AdminTransportController> {
  const AdminTransportView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Transport",
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.adminFeesTileList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Obx(
                        () => CustomCardTile(
                      icon: controller.adminFeesTileList[index].icon,
                      title: controller.adminFeesTileList[index].title,
                      iconColor: AppColors.primaryColor.withOpacity(0.7),
                      onTap: () {
                        controller.selectIndex.value = index;
                        AppFunctions.getAdminHomeNavigation(
                            title: controller.adminFeesTileList[index].value);
                        
                      },
                      isSelected: controller.selectIndex.value == index,
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
