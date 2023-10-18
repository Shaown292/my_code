import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_homework_controller.dart';

class StudentHomeworkView extends GetView<StudentHomeworkController> {
  const StudentHomeworkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHomeworkView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentHomeworkView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
