import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../controllers/dormitory_controller.dart';

class DormitoryView extends GetView<DormitoryController> {
  const DormitoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DormitoryView'),
        centerTitle: true,
      ),
      body: Obx(() => Column(
        children: [
          controller.loadingController.isLoading ? LoadingWidget() : Expanded(
            child: ListView.builder(
              itemCount: controller.dormitoryList.length*200,
              itemBuilder: (itemBuilder, int index) => Text('jhjhd'),
            ),
          )
        ],
      )),
    );
  }
}
