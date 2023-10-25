import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/active_exam/views/widget/active_exam_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../controllers/active_exam_controller.dart';

class ActiveExamView extends GetView<ActiveExamController> {
  const ActiveExamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Active Exam",
      body: CustomBackground(
        customWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpacing,
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{

                },
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return  ActiveExamTile(
                        title: "New Exam",
                        subject: "Bangla",
                        startingTime: "21/03/2023\n(12:35)am",
                        endingTime: "21/03/2023\n(3:35)am",
                        activeStatus: "Closed",
                        activeStatusColor: AppColors.activeExamStatusBlueColor,
                        color: index % 2 == 0? Colors.white : AppColors.homeworkWidgetColor,
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
