import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_book_list_controller.dart';

class AdminBookListView extends GetView<AdminBookListController> {
  const AdminBookListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminBookListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminBookListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
