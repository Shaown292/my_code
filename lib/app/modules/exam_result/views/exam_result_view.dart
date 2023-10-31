import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/exam_result/views/widget/exam_result_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/exam_result_controller.dart';

class ExamResultView extends GetView<ExamResultController> {
  const ExamResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Exam Result",
      body: CustomBackground(
        customWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpacing,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (context, index){

                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(()=> StudyButton(
                            title: "Class(A)",
                            onItemTap: () {
                              controller.selectIndex.value = index;
                            },
                            isSelected: controller.selectIndex.value == index,
                          ),)

                      );
                    }),
              ),
            ),
            20.verticalSpacing,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  debugPrint("Refresh");
                },
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context , index){
                      return   ExamResultTile(
                        title: "Pair Match Test",
                        startingTime: "21/03/2023\n(12:35)am",
                        endingTime: "21/03/2023\n(3:35)am",
                        activeStatus: "Passed",
                        activeStatusColor: AppColors.homeworkStatusGreenColor,
                        color: index % 2 == 0? Colors.white : AppColors.homeworkWidgetColor,
                      );
                    }),
              ),
            )

          ],
        )
      ),
    );
  }
}
