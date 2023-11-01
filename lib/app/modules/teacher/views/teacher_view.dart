import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/teacher/views/widget/teacher_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/loader/loading.widget.dart';
import '../controllers/teacher_controller.dart';

class TeacherView extends GetView<TeacherController> {
  const TeacherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Teacher",
      body: CustomBackground(

          customWidget: RefreshIndicator(
            onRefresh: () async {},
            child: Column(
              children: [
                10.verticalSpacing,
                controller.loadingController.isLoading
                    ? const LoadingWidget()
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return TeacherTile(
                                color: index % 2 == 0
                                    ? Colors.white :AppColors.profileCardTextColor
                                    ,
                                teachersName: "Lomor",
                                teachersEmail: "lomor@gmail.com",
                                teachersPhoneNo: "0187881781",
                              );
                            }),
                      ),
              ],
            ),
          )),
    );
  }
}
