import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_individual_details_controller.dart';

class AdminClassAttendanceIndividualDetailsView
    extends GetView<AdminClassAttendanceIndividualDetailsController> {
  const AdminClassAttendanceIndividualDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminClassAttendanceIndividualDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminClassAttendanceIndividualDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
