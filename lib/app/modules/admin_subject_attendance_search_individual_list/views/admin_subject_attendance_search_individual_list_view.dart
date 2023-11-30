import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/student_list_tile/student_list_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_list_controller.dart';

class AdminSubjectAttendanceSearchIndividualListView
    extends GetView<AdminSubjectAttendanceSearchIndividualListController> {
  const AdminSubjectAttendanceSearchIndividualListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return StudentListTile(
                      onTap: () {
                        Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_DETAILS);
                      },
                      studentName: "Jahid",
                      imageURL: "URL",
                      classSection: "Tulip",
                      studentClass: "Five",
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
