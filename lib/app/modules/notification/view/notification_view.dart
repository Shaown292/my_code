import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/view/widget/NotificationListWidget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/view/widget/noNotificationWidget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/view/widget/notification_app_bar_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/button/primary_button.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController>{
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {

    return CustomScaffoldWidget(

      appBar:  NotificationAppBarWidget(),

      bodyWidget: CustomBackground(

          customWidget: Column(
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "You have ${controller.notificationModel!.data!.unreadNotificationsCount} New notification",
                      style: AppTextStyle.notificationText,
                    ),
                    const PrimaryButton(
                      title: AppText.notificationRaed,
                      width: 110,
                    )
                  ],
                ),
              ),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }


                if(controller.isLoading.value == false && controller.notificationModel == null){
                  return const NoNotificationWidget();
                }

                return NotificationListWidget(unreadNotifications: controller.notificationModel!.data!.unreadNotifications!);
              }
              ),


              30.verticalSpacing
            ],
          )
      ),
    );
  }

}