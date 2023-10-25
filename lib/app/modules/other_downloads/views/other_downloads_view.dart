import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/other_downloads/views/widget/other_downloads_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../utilities/widgets/loader/loading.widget.dart';
import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../controllers/other_downloads_controller.dart';

class OtherDownloadsView extends GetView<OtherDownloadsController> {
  const OtherDownloadsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() => InfixEduScaffold(
      title: "Assignment",
      body: RefreshIndicator(

        onRefresh: () async {
          controller.studentOthersDownloadList.clear();
          controller.getStudentOthersDownloadList();
        },
        child: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                controller.loadingController.isLoading ? const LoadingWidget() : controller.studentOthersDownloadList.isEmpty ? Expanded(
                  child: ListView.builder(
                    itemCount: controller.studentOthersDownloadList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return  OtherDownloadsTile(
                        contentTitle: controller.studentOthersDownloadList[index].contentTitle ?? '',
                        topic: controller.studentOthersDownloadList[index].availableFor ?? '',
                        date: controller.studentOthersDownloadList[index].uploadDate ?? '',
                      );
                    },),
                ) : const NoDataAvailableWidget()

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
