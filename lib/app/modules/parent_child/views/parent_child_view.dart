import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/student_list_tile/student_list_tile.dart';

import 'package:get/get.dart';

import '../controllers/parent_child_controller.dart';

class ParentChildView extends GetView<ParentChildController> {
  const ParentChildView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Obx(() => Expanded(
                child: RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    controller.getParentsChildData(parentId: controller.globalRxVariableController.parentId.value!);
                  },
                  child: controller.loadingController.isLoading ? const LoadingWidget() : controller.parentChildList.isNotEmpty ? ListView.builder(
                    itemCount: controller.parentChildList.length,
                    itemBuilder: (context, index) {
                      return StudentListTile(
                        onTap: () {
                          controller.globalRxVariableController.studentId.value = controller.parentChildList[index].studentId;
                          Get.toNamed(Routes.HOME, arguments: {
                            "homeListTile" : studentList,
                          });
                        },
                        studentName: controller.parentChildList[index].fullName,
                        imageURL: controller.parentChildList[index].imageUrl,
                        isMultipleSectionAvailable: true,
                        classSectionList: const [],
                      );
                    },
                  ) : const NoDataAvailableWidget(),
                )

            ),),
          ],
        ),
      ),
    );
  }
}
