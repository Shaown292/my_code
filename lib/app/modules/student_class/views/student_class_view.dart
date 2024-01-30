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
    return Obx(
          () => InfixEduScaffold(
        title: "Class".tr,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              CustomBackground(
                customWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Jitsi
                    ClassTile(
                      onlineClassTitle: "Jitsi",
                      onlineClassSubTitle: "Virtual Class",
                      onlineClassMeeting: "Virtual meeting",
                      onTap: () {
                        controller.isJitsiTapped.value = !controller.isJitsiTapped.value;
                        // Get.to(() => const LaunchWebView(launchUrl: 'https://pub.dev/packages/flutter_inappwebview/changelog', title: 'Title',));
                      },
                      isTapped: controller.isJitsiTapped.value,
                      onSubTitleTap: () {
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "jitsi",
                        });
                      },
                      onMeetingTap: (){
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "jitsi_meeting",
                        });
                      },
                    ),
                    20.verticalSpacing,
                    /// Zoom
                    ClassTile(
                      onlineClassTitle: "Zoom",
                      onlineClassSubTitle: "Virtual Class",
                      onlineClassMeeting: "Virtual meeting",
                      onTap: () {
                        controller.isZoomTapped.value = !controller.isZoomTapped.value;
                      },
                      isTapped: controller.isZoomTapped.value,
                      onSubTitleTap: () {
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "zoom",
                        });
                      },
                      onMeetingTap: (){
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "zoom_meeting",
                        });
                      },
                    ),
                    20.verticalSpacing,
                    /// Google meet
                    ClassTile(
                      onlineClassTitle: "Google Meet",
                      onlineClassSubTitle: "Virtual Class",
                      onlineClassMeeting: "Virtual meeting",
                      onTap: () {
                        controller.isGoogleMeetTap.value = !controller.isGoogleMeetTap.value;
                      },
                      isTapped: controller.isGoogleMeetTap.value,
                      onSubTitleTap: () {
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "google_meet_class",
                        });
                      },
                      onMeetingTap: (){
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "google_meet_meeting",
                        });
                      },
                    ),
                    20.verticalSpacing,
                    /// Big Blue Button
                    ClassTile(
                      onlineClassTitle: "Big Blue Button",
                      onlineClassSubTitle: "Virtual Class",
                      onlineClassMeeting: "Virtual meeting",
                      onTap: () {
                        controller.isBigBlueButtonTap.value = !controller.isBigBlueButtonTap.value;
                      },
                      isTapped: controller.isBigBlueButtonTap.value,
                      onSubTitleTap: () {
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "big_blue_button",
                        });
                      },
                      onMeetingTap: (){
                        Get.toNamed(Routes.VIRTUAL_CLASS_LIST, arguments: {
                          "online_class" : "big_blue_button_meeting",
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
