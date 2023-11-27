import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_controller.dart';

class AdminSubjectAttendanceSearchIndividualView
    extends GetView<AdminSubjectAttendanceSearchIndividualController> {
  const AdminSubjectAttendanceSearchIndividualView({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminSubjectAttendanceSearchIndividualView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminSubjectAttendanceSearchIndividualView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
