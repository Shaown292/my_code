import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_content_list_controller.dart';
import 'widget/content_tile.dart';

class AdminContentListView extends GetView<AdminContentListController> {
  const AdminContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Content List",
      body: CustomBackground(
        customWidget: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            controller.getAdminContentList();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => controller.loadingController.isLoading
                      ? SizedBox(
                          height: Get.height,
                          child: const Column(
                            children: [
                              LoadingWidget(),
                            ],
                          ),
                        )
                      : controller.contentList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.contentList.length,
                              itemBuilder: (context, index) {
                                return ContentTile(
                                  title: controller
                                      .contentList[index].contentTitle,
                                  contentType:
                                      controller.contentList[index].contentType,
                                  date:
                                      controller.contentList[index].uploadDate,
                                  availableFor: controller
                                      .contentList[index].availableFor,
                                  onDeleteTap: () => controller.showDialog(
                                    id: controller.contentList[index].id!,
                                    index: index,
                                  ),
                                  onDownloadTap: () =>
                                      controller.fileDownload(),
                                );
                              },
                            )
                          : const Center(
                              child: NoDataAvailableWidget(),
                            ),
                ),
                50.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
