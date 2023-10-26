import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/apply_leave_controller.dart';

class ApplyLeaveView extends GetView<ApplyLeaveController> {
  const ApplyLeaveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ApplyLeaveView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ApplyLeaveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
