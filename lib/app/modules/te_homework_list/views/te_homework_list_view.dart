import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_homework_list_controller.dart';

class TeHomeworkListView extends GetView<TeHomeworkListController> {
  const TeHomeworkListView({super.key});
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Homework List",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 50,
                  itemBuilder: (context, index){
                return  HomeworkTile(
                  createDate: "21-03-2023",
                  submissionDate: "25-03-2023",
                  evaluation: "N/A",
                  marks: "10",
                  subject: "Science",
                  onTap: ()=> Get.toNamed(Routes.TE_HOMEWORK_EVALUATION),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
