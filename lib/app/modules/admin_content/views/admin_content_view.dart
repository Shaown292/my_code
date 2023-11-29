import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_content_controller.dart';

class AdminContentView extends GetView<AdminContentController> {
  const AdminContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminContentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminContentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
