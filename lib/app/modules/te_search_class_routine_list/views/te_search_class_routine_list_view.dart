import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_search_class_routine_list_controller.dart';

class TeSearchClassRoutineListView
    extends GetView<TeSearchClassRoutineListController> {
  const TeSearchClassRoutineListView({super.key});
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      body: CustomBackground(
        customWidget: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
