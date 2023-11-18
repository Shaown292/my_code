import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/assignment/views/widget/assignment_card.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class AssignmentView extends GetView<AssignmentController> {
  const AssignmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
      title: "Assignment",
      body: RefreshIndicator(
        onRefresh: () async {
          controller.studentAssignmentList.clear();
          controller.getStudentAssignmentList();
        },
        child: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                controller.loadingController.isLoading ? const LoadingWidget() : controller.studentAssignmentList.isNotEmpty ? Expanded(
                  child: ListView.builder(
                    itemCount: controller.studentAssignmentList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return AssignmentCard(
                        onTap: (){
                          controller.showStudentAssignmentDetailsBottomSheet(index: index);
                        },
                        assignmentTile: controller.studentAssignmentList[index].contentTitle,
                        assignmentDetails: "Assigned to ${controller.studentAssignmentList[index].availableFor}",
                        dueDate: controller.studentAssignmentList[index].uploadDate,
                        cardBackgroundColor: Colors.white,
                      );
                    },),
                ) : const NoDataAvailableWidget()

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
