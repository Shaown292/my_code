import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_individual_list_controller.dart';

class AdminClassAttendanceSearchIndividualListView
    extends GetView<AdminClassAttendanceSearchIndividualListController> {
  const AdminClassAttendanceSearchIndividualListView({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminClassAttendanceSearchIndividualListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminClassAttendanceSearchIndividualListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
