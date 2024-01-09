import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_class/views/widget/class_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/student_class_controller.dart';

class StudentClassView extends GetView<StudentClassController> {
  const StudentClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Class".tr,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            CustomBackground(
              customWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpacing,
                  Expanded(
                      child: Column(
                    children: [
                      Obx(
                        () => ClassTile(
                          onlineClassTitle: "Zoom",
                          onlineClassSubTitle: "Virtual Class",
                          onTap: () {
                            controller.titleBackgroundColor.value =
                                !controller.titleBackgroundColor.value;
                            print(
                                " ::::: ${controller.titleBackgroundColor.value}");
                          },
                          isTapped: controller.titleBackgroundColor.value,
                          onSubTitleTap: (){
                            Get.toNamed(Routes.VIRTUAL_CLASS_LIST);
                          },
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
