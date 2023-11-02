import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/teacher/views/widget/teacher_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/loader/loading.widget.dart';
import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../controllers/teacher_controller.dart';

class TeacherView extends GetView<TeacherController> {
  const TeacherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Teacher",
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: CustomBackground(
          customWidget: Obx(
            () => RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () async {
                controller.teacherList.clear();
                controller.getAllTeacherList(
                    recordId:
                        controller.homeController.studentRecordList[0].id);
              },
              child: Column(
                children: [
                  10.verticalSpacing,
                  controller.loadingController.isLoading
                      ? const LoadingWidget()
                      : controller.teacherList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.teacherList.length,
                              itemBuilder: (context, index) {
                                return TeacherTile(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : AppColors.profileCardTextColor,
                                  teachersName:
                                      controller.teacherList[index].fullName,
                                  teachersEmail:
                                      controller.teacherList[index].email,
                                  teachersPhoneNo:
                                      controller.teacherList[index].mobile,
                                );
                              },
                            )
                          : const Center(child: NoDataAvailableWidget()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
