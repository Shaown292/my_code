import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_list_controller.dart';

class AdminSubjectAttendanceSearchIndividualListView
    extends GetView<AdminSubjectAttendanceSearchIndividualListController> {
  const AdminSubjectAttendanceSearchIndividualListView({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminSubjectAttendanceSearchIndividualListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminSubjectAttendanceSearchIndividualListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
