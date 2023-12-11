import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/app_functions/functionality.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_controller.dart';

class TeHomeworkView extends GetView<TeHomeworkController> {
  const TeHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      leadingIcon: const SizedBox(),
      title: "Homework",
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.teacherHomeworkTileList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Obx(
                  () => CustomCardTile(
                    icon: controller.teacherHomeworkTileList[index].icon,
                    title: controller.teacherHomeworkTileList[index].title,
                    iconColor: AppColors.primaryColor,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getTeacherHomeNavigation(
                        title: controller.teacherHomeworkTileList[index].value,

                      );
                    },
                    isSelected: controller.selectIndex.value == index,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
