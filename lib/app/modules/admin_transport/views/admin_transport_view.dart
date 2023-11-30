import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_transport_controller.dart';

class AdminTransportView extends GetView<AdminTransportController> {
  const AdminTransportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminTransportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminTransportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
