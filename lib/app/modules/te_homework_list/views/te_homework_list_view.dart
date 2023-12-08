import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_list_controller.dart';

class TeHomeworkListView extends GetView<TeHomeworkListController> {
  const TeHomeworkListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeHomeworkListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeHomeworkListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
