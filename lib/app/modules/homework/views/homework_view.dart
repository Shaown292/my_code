


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeworkView extends GetView<GetxController>{
  const HomeworkView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
      ),
    );
  }

}