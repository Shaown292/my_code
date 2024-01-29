import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/virtual_class_list/controllers/virtual_class_list_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/virtual_class_list/views/widget/virtual_class_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/clipboard/custom_clipboard.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

class VirtualClassListView extends GetView<VirtualClassListController> {
  const VirtualClassListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Virtual Class (${controller.title})".tr,
          body: CustomBackground(
            customWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpacing,
                Expanded(
                  child: controller.meetingLoader.value
                      ? const SecondaryLoadingWidget()
                      : controller.meetingList.isNotEmpty
                          ? RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {
                                controller.meetingList.clear();
                                controller.getZoomMeetingList();
                              },
                              child: ListView.builder(
                                itemCount: controller.meetingList.length,
                                itemBuilder: (context, index) {
                                  String colorCode = '';
                                  if (controller
                                          .meetingList[index].currentStatus
                                          ?.toUpperCase() ==
                                      'CLOSED') {
                                    colorCode = '0xFFF95452';
                                  } else if (controller
                                          .meetingList[index].currentStatus
                                          ?.toUpperCase() ==
                                      'WAITING') {
                                    colorCode = '0xFFFFBE00';
                                  } else {
                                    colorCode = '0xFF3AC172';
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: VirtualClassTile(
                                      topic:
                                          controller.meetingList[index].topic,
                                      startingTime: controller
                                          .meetingList[index].startTime,
                                      duration: controller
                                          .meetingList[index].duration
                                          .toString(),
                                      meetingPassword: controller
                                          .meetingList[index].meetingPassword,
                                      activeStatusColor:
                                          Color(int.tryParse(colorCode)!),
                                      activeStatus: controller
                                          .meetingList[index].currentStatus,
                                      date: controller
                                          .meetingList[index].startDate,
                                      onTap: () {
                                        if (controller.meetingList[index]
                                                    .currentStatus
                                                    ?.toUpperCase() ==
                                                'JOIN' ||
                                            controller.meetingList[index]
                                                    .currentStatus
                                                    ?.toUpperCase() ==
                                                'START') {
                                          if (controller.onlineClass.value ==
                                              "big_blue_button" || controller.onlineClass.value ==
                                              "big_blue_button_meeting") {
                                            Get.toNamed(Routes.LAUNCH_WEBVIEW,
                                                arguments: {
                                                  'url': controller
                                                      .meetingList[index]
                                                      .joinUrl,
                                                  "title": controller
                                                      .meetingList[index].topic,
                                                });
                                          } else if (controller
                                                  .onlineClass.value ==
                                              'zoom' || controller
                                              .onlineClass.value ==
                                              'zoom_meeting') {
                                            controller.openZoom(
                                              meetingId: controller
                                                      .meetingList[index]
                                                      .meetingId ??
                                                  '',
                                              status: controller
                                                      .meetingList[index]
                                                      .currentStatus ??
                                                  '',
                                            );
                                          } else if (controller
                                                  .onlineClass.value ==
                                              "jitsi") {
                                            // print('object');
                                            controller.join(
                                              roomId: controller
                                                  .meetingList[index]
                                                  .meetingId!,
                                            );
                                          } else if (controller
                                                  .onlineClass.value ==
                                              'google_meet_class' || controller.onlineClass.value == 'google_meet_meeting') {
                                            controller.openGoogleMeet(
                                                status: controller
                                                        .meetingList[index]
                                                        .currentStatus ??
                                                    "",
                                                url: controller
                                                        .meetingList[index]
                                                        .joinUrl ??
                                                    "");
                                          }
                                        }
                                      },
                                      onTapForCopy: () {
                                        copyToClipboard(controller
                                            .meetingList[index]
                                            .meetingPassword!);
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: NoDataAvailableWidget(),
                            ),
                ),
                30.verticalSpacing,
              ],
            ),
          ),
        ));
  }
}
