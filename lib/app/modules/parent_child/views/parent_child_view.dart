import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/parent_child_controller.dart';

class ParentChildView extends GetView<ParentChildController> {
  const ParentChildView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ParentChildView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ParentChildView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
