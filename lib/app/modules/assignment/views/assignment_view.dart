import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class AssignmentView extends GetView<AssignmentController> {
  const AssignmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AssignmentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AssignmentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
