import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subjects_controller.dart';

class SubjectsView extends GetView<SubjectsController> {
  const SubjectsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubjectsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubjectsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
