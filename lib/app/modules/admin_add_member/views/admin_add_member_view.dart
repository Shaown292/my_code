import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_member_controller.dart';

class AdminAddMemberView extends GetView<AdminAddMemberController> {
  const AdminAddMemberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminAddMemberView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminAddMemberView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
