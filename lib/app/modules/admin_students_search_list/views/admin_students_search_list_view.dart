import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search_list/views/widget/student_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_students_search_list_controller.dart';

class AdminStudentsSearchListView
    extends GetView<AdminStudentsSearchListController> {
  const AdminStudentsSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List",
      body: CustomBackground(
        customWidget: Column(
          children: [

            Expanded(
              child: controller.studentData!.isNotEmpty
                  ? ListView.builder(
                itemCount: controller.studentData!.length,
                      itemBuilder: (context, index) {
                        return StudentListTile(
                          studentName: controller.studentData![index].fullName,
                          imageURL: controller.studentData![index].studentPhoto,
                          classSectionList: controller.studentData![index].classSection,
                        );
                      },
                    )
                  : const NoDataAvailableWidget(),
            )
          ],
        ),
      ),
    );
  }
}
