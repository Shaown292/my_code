import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_search_subject_attendance_controller.dart';

class StudentSearchSubjectAttendanceView
    extends GetView<StudentSearchSubjectAttendanceController> {
  const StudentSearchSubjectAttendanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentSearchSubjectAttendanceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentSearchSubjectAttendanceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
