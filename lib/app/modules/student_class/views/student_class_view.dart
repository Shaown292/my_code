import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_class_controller.dart';

class StudentClassView extends GetView<StudentClassController> {
  const StudentClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentClassView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(

          'StudentClassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
