import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/view/widget/notification_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/view/widget/notification_app_bar_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../../domain/core/model/notification/notification_model.dart';
import '../../../data/constants/app_text.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/button/primary_button.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScaffoldWidget(
        appBar: NotificationAppBarWidget(
          notificationCount: controller.unreadNotificationCount,
        ),
        bodyWidget: CustomBackground(
            customWidget: RefreshIndicator(
          onRefresh: () async {
            controller.fetchNotifications();
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "You have ${controller.unreadNotificationCount} New notification",
                      style: AppTextStyle.notificationText,
                    ),
                    const PrimaryButton(
                      title: AppText.notificationRaed,
                      width: 110,
                    )
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : controller.unReadNotificationList.isEmpty
                      ? const NoDataAvailableWidget()
                      : Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  controller.unReadNotificationList.length,
                              itemBuilder: (context, index) {
                                UnreadNotifications? notificationsItem =
                                    controller.unReadNotificationList[index];

                                return NotificationListTile(
                                  message: notificationsItem.message ?? '',
                                  notificationDate: formatTimeAgo(DateTime.parse(notificationsItem.createdAt ?? '')),
                                  userPhoto: notificationsItem.userPhoto,
                                );
                              }),
                        ),
              30.verticalSpacing
            ],
          ),
        )),
      ),
    );
  }

  /// Time Ago Calculator
  String formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'a few moments ago';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes != 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hour${hours != 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return '$days day${days != 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months month${months != 1 ? 's' : ''} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years year${years != 1 ? 's' : ''} ago';
    }
  }

}
