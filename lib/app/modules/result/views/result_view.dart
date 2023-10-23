import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/result/views/widget/result_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/study_button/study_button.dart';

import 'package:get/get.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Result",
      body: CustomBackground(
        customWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpacing,
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StudyButton(
                  title: "Class One (A)",
                ),
                10.horizontalSpacing,
                const StudyButton(
                  title: "Class One (A)",
                  color: Colors.white,
                  textStyle: AppTextStyle.cardTextStyle12PurpleW400,
                  borderColor: AppColors.primaryColor,
                ),
              ],
            ),
            20.verticalSpacing,
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context , index){
                    return  ResultTile(
                      title: "Match",
                      subject: "Bangla",
                      marks: "100",
                      obtain: "81",
                      grade: "A",
                      color: index % 2 == 0 ? Colors.white : AppColors.profileCardTextColor,
                    );
                  }),
            )

          ],
        ),
      ),
    );
  }
}
