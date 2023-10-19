import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/app_functions/functionality.dart';
import '../controllers/study_materials_controller.dart';

class StudyMaterialsView extends GetView<StudyMaterialsController> {
  const StudyMaterialsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Study Materials',

      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.studyMaterialTileList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Obx(() => CustomCardTile(
                  icon: controller.studyMaterialTileList[index].icon,
                  title: controller.studyMaterialTileList[index].title,
                  onTap: () {
                    controller.selectIndex.value = index;
                    AppFunctions.getStudentDashboardNavigation(title: controller.studyMaterialTileList[index].value);
                  },
                  isSelected: controller.selectIndex.value == index,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}