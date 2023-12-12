import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/te_about_controller.dart';

class TeAboutView extends GetView<TeAboutController> {
  const TeAboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeAboutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeAboutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
