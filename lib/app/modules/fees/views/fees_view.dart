import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fees_controller.dart';

class FeesView extends GetView<FeesController> {
  const FeesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
