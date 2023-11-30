import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/student_list_tile/student_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_list_controller.dart';

class AdminSubjectAttendanceSearchListView
    extends GetView<AdminSubjectAttendanceSearchListController> {
  const AdminSubjectAttendanceSearchListView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child:  ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return StudentListTile(
                    onTap: () {

                    },
                    studentName: "Jassy",
                    imageURL: "URL",
                    classSection: "Section",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
