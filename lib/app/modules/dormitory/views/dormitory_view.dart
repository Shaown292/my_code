import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dormitory_controller.dart';

class DormitoryView extends GetView<DormitoryController> {
  const DormitoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DormitoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DormitoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
