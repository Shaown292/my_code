import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/notice_tile/notice_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../controllers/notice_controller.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Notice",
        body: CustomBackground(
          customWidget: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              controller.allNoticeList.clear();
              controller.getAllNoticeList();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.loadingController.isLoading
                      ? SizedBox(
                          height: Get.height,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : controller.allNoticeList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.allNoticeList.length,
                              itemBuilder: (context, index) {
                                return NoticeTile(
                                  noticeTitle: controller
                                      .allNoticeList[index].noticeTitle,
                                  noticeDetails: controller
                                      .allNoticeList[index].noticeMessage,
                                  noticeDate:
                                      controller.allNoticeList[index].publishOn,
                                  cardBackgroundColor: Colors.white,
                                  onTap: () {
                                    controller.showNoticeDetailsBottomSheet(
                                        index: index,
                                        bottomSheetBackgroundColor:
                                            Colors.white);
                                  },
                                );
                              })
                          : const Center(
                              child: NoDataAvailableWidget(),
                            ),
                  50.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
