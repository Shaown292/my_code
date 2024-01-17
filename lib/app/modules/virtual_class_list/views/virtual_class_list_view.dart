import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/show_status_tile/show_status_tile.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/virtual_class_list_controller.dart';

class VirtualClassListView extends GetView<VirtualClassListController> {
  const VirtualClassListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
      title: "Virtual Class List".tr,
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
                    child: ListView.builder(
                      itemCount: controller.zoomMeetingList.length,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                          child: ShowStatusTile(
                            firstTitle: "Topic",
                            firstValue: controller.zoomMeetingList[index].topic,
                            secondTitle: "Meeting Id",
                            secondValue: controller.zoomMeetingList[index].meetingId,
                            thirdTitle: "Start Time",
                            thirdValue: controller.zoomMeetingList[index].startTime ,
                            activeStatus: controller.zoomMeetingList[index].currentStatus,
                            activeStatusColor: controller.zoomMeetingList[index].currentStatus == 'JOIN' || controller.zoomMeetingList[index].currentStatus == 'START' ? Colors.green : Colors.red,
                            onStatusTap: () async {

                              controller.openZoom(meetingId: controller.zoomMeetingList[index].meetingId ?? '', status: controller.zoomMeetingList[index].currentStatus ?? '');

                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
