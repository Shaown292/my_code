import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_add_homework_controller.dart';

class TeAddHomeworkView extends GetView<TeAddHomeworkController> {
  const TeAddHomeworkView({super.key});
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      title: "Add Homework",
      body: CustomBackground(
        customWidget: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
