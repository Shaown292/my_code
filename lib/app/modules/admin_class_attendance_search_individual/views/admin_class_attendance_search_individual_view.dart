import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_individual_controller.dart';

class AdminClassAttendanceSearchIndividualView
    extends GetView<AdminClassAttendanceSearchIndividualController> {
  const AdminClassAttendanceSearchIndividualView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminClassAttendanceSearchIndividualView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminClassAttendanceSearchIndividualView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
