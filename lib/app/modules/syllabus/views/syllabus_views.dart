import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/syllabus/views/widgets/syllabus_topic_wise.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/appbar/custom_appbar.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/button/primary_button.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/common_widgets/custom_container_widget.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';
import '../controller/syllabus_controller.dart';

class SyllabusView extends GetView<SyllabusController> {
  const SyllabusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
      title: "Syllabus",
      body: CustomBackground(
        customWidget: controller.loadingController.isLoading ? const LoadingWidget() : ListView.builder(
          itemCount: controller.syllabusList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) => SyllabusTopicWise(
            contentTitle: controller.syllabusList[index].contentTitle ?? '',
            topic: controller.syllabusList[index].description ?? '',
            date: controller.syllabusList[index].uploadDate ?? '',
            onTap: () {
              print('object""""""""""');
              // controller.downloadFile(url: InfixApi.syllabusDownloadUrl(controller.syllabusList[index].id!), filename: controller.syllabusList[index].contentTitle ?? '');
              // PermissionCheck().checkPermissions(context);
              // controller.downloadFile(InfixApi.syllabusDownloadUrl(controller.syllabusList[index].id!), controller.syllabusList[index].contentTitle ?? '');

              // PermissionCheck().checkPermissions(context);
              Get.dialog(
                AccountDeleteDialogue(
                  onYesTap: () {
                    Navigator.pop(context);
                    controller.downloadFile(InfixApi.syllabusDownloadUrl(controller.syllabusList[index].id!));
                  },
                  title: 'Confirmation',
                  subTitle: "Text.logoutWarningMsg",
                  noText: 'cancel',
                  yesText: 'logout',
                ),
              );


            },
          ),
        ),
      ),
    ));
  }
}
