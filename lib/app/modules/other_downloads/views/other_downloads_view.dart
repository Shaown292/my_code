import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/other_downloads/views/widget/other_downloads_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/content_tile/content_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/permission_check/permission_check.dart';
import 'package:get/get.dart';
import '../../../utilities/widgets/loader/loading.widget.dart';
import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../controllers/other_downloads_controller.dart';

class OtherDownloadsView extends GetView<OtherDownloadsController> {
  const OtherDownloadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Other Downloads",
        body: RefreshIndicator(
          onRefresh: () async {
            controller.studentOthersDownloadList.clear();
            controller.getStudentOthersDownloadList();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomBackground(
                  customWidget: controller.loadingController.isLoading
                      ? const Expanded(
                          child: LoadingWidget(),
                        )
                      : controller.studentOthersDownloadList.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  controller.studentOthersDownloadList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: OtherDownloadsTile(
                                      contentTitle: controller
                                          .studentOthersDownloadList[index]
                                          .contentTitle,
                                      topic: controller
                                          .studentOthersDownloadList[index]
                                          .availableFor,
                                      date: controller
                                              .studentOthersDownloadList[index]
                                              .uploadDate ??
                                          '',
                                      onTap: () {
                                        PermissionCheck()
                                            .checkPermissions(context);
                                        Get.dialog(
                                          CustomPopupDialogue(
                                            onYesTap: () {
                                              Navigator.pop(context);
                                              controller
                                                      .studentOthersDownloadList[
                                                          index]
                                                      .uploadFile!
                                                      .isNotEmpty
                                                  ? FileDownloadUtils().downloadFiles(
                                                      url: controller
                                                          .studentOthersDownloadList[
                                                              index]
                                                          .uploadFile!,
                                                      title: controller
                                                          .studentOthersDownloadList[
                                                              index]
                                                          .contentTitle!)
                                                  : showBasicSuccessSnackBar(
                                                      message:
                                                          'No File Available.');
                                            },
                                            title: 'Confirmation',
                                            subTitle: AppText.downloadMessage,
                                            noText: 'No',
                                            yesText: 'Download',
                                          ),
                                        );
                                      },
                                    ));
                              },
                            )
                          : const NoDataAvailableWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
