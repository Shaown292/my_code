import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_leave_controller.dart';

class AdminLeaveView extends GetView<AdminLeaveController> {
  const AdminLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminLeaveView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminLeaveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
