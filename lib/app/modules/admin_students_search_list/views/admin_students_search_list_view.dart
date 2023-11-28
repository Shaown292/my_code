import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search_list/views/widget/student_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_students_search_list_controller.dart';

class AdminStudentsSearchListView
    extends GetView<AdminStudentsSearchListController> {
  const AdminStudentsSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Students List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context, index){
                return const StudentListTile(
                  studentSection: "Rose",
                  studentClass: "Play Group",
                  studentName: "Syed Nahid",
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
