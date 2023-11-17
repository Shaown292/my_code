import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notice/views/widget/notice_card.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../controllers/notice_controller.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Notice",
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: CustomBackground(
            customWidget: Obx(
              () => RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  controller.allNoticeList.clear();
                  controller.getAllNoticeList();
                },
                child: Column(
                  children: [
                    controller.loadingController.isLoading
                        ? const LoadingWidget()
                        : controller.allNoticeList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.allNoticeList.length,
                                itemBuilder: (context, index) {
                                  return NoticeCard(
                                    noticeTitle: controller
                                        .allNoticeList[index].noticeTitle,
                                    noticeDetails: controller
                                        .allNoticeList[index].noticeMessage,
                                    noticeDate: controller
                                        .allNoticeList[index].publishOn,
                                    onTap: () {
                                      controller.showNoticeDetailsBottomSheet(
                                          index: index);
                                    },
                                  );
                                })
                            : const Center(
                                child: NoDataAvailableWidget(),
                              ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
