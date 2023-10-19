import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_materials_controller.dart';

class StudyMaterialsView extends GetView<StudyMaterialsController> {
  const StudyMaterialsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyMaterialsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudyMaterialsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
