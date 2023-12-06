import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_wallet_controller.dart';

class StudentWalletView extends GetView<StudentWalletController> {
  const StudentWalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentWalletView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentWalletView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
