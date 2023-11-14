import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_lesson_plan_controller.dart';

class StudentLessonPlanView extends GetView<StudentLessonPlanController> {
  const StudentLessonPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentLessonPlanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentLessonPlanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
