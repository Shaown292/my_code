
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/staff_controller.dart';

class StaffView extends GetView<StaffController> {
  const StaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Staff",
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const SecondaryLoadingWidget()
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.staffRoleList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => CustomCardTile(
                              icon: ImagePath.add,
                              title: controller.staffRoleList[index].name ?? "",
                              iconColor: AppColors.primaryColor.withOpacity(0.7),
                              onTap: () {
                                controller.selectIndex.value = index;
                                Get.toNamed(
                                  Routes.STAFF_LIST,
                                  arguments: {
                                    "staff_role_id":
                                        controller.staffRoleList[index].id ,
                                    "staff_role_name" : controller.staffRoleList[index].name

                                  },
                                );
                              },
                              isSelected: controller.selectIndex.value == index,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
