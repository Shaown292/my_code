import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/te_add_homework_controller.dart';

class TeAddHomeworkView extends GetView<TeAddHomeworkController> {
  const TeAddHomeworkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeAddHomeworkView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeAddHomeworkView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
