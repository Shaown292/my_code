import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/te_subjects_controller.dart';

class TeSubjectsView extends GetView<TeSubjectsController> {
  const TeSubjectsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeSubjectsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeSubjectsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
