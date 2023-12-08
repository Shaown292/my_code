import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/te_academic_controller.dart';

class TeAcademicView extends GetView<TeAcademicController> {
  const TeAcademicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeAcademicView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeAcademicView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
