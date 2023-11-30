import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_book_controller.dart';

class AdminAddBookView extends GetView<AdminAddBookController> {
  const AdminAddBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminAddBookView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminAddBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
