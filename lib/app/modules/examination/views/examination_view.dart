import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utilities/app_functions/functionality.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/examination_controller.dart';

class ExaminationView extends GetView<ExaminationController> {
  const ExaminationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Examination',
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.examinationTileList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Obx(
                      () => CustomCardTile(
                    icon: controller.examinationTileList[index].icon,
                    title: controller.examinationTileList[index].title,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getStudentDashboardNavigation(
                          title: controller.examinationTileList[index].value);
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
