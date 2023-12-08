import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/content_tile/content_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/permission_check/permission_check.dart';

import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class AssignmentView extends GetView<AssignmentController> {
  const AssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Assignment",
        body: RefreshIndicator(
          onRefresh: () async {
            controller.studentAssignmentList.clear();
            controller.getStudentAssignmentList();
          },
          child: CustomBackground(
            customWidget: controller.loadingController.isLoading
                ? const LoadingWidget()
                : controller.studentAssignmentList.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: controller.studentAssignmentList.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return ContentTile(
                            title: controller
                                .studentAssignmentList[index].contentTitle,
                            details:
                                "Assigned to ${controller.studentAssignmentList[index].availableFor}",
                            dueDate: controller
                                .studentAssignmentList[index].uploadDate,
                            cardBackgroundColor: Colors.white,
                            onTap: () {
                              PermissionCheck().checkPermissions(context);
                              Get.dialog(
                                CustomPopupDialogue(
                                  onYesTap: () {
                                    Navigator.pop(context);
                                    controller.studentAssignmentList[index]
                                            .uploadFile!.isNotEmpty
                                        ? FileDownloadUtils().downloadFiles(
                                            url: controller
                                                .studentAssignmentList[
                                                    index]
                                                .uploadFile!,
                                            title: controller
                                                .studentAssignmentList[
                                                    index]
                                                .contentTitle!)
                                        : showBasicSuccessSnackBar(
                                            message: 'No File Available.');
                                  },
                                  title: 'Confirmation',
                                  subTitle: AppText.downloadMessage,
                                  noText: 'No',
                                  yesText: 'Download',
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                    : const NoDataAvailableWidget(),
          ),
        ),
      ),
    );
  }
}
