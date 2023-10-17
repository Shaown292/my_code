import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/database/auth_database.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/notification/notification_model.dart';
import 'package:get/get.dart';

import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/message/snack_bars.dart';

class NotificationController extends GetxController {

  @override
  void onInit() {
  fetchNotifications();
    super.onInit();
  }

  RxBool isLoading = false.obs;


 List<UnreadNotifications> unReadNotificationList = [];
 int unreadNotificationCount = 0;

  void fetchNotifications() async {

    isLoading.value = true;

    try {
      final res = await BaseClient().getData(
        url: "https://spondan.com/infixedu/api/v2/all-notification-list",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "${AuthDatabase.instance.getToken()}"
        },

      );


      NotificationModel notificationModel = NotificationModel.fromJson(res);

      if (notificationModel.success == true) {
        unreadNotificationCount = notificationModel.data?.unreadNotificationsCount ?? 0;
        if (notificationModel.data?.unreadNotifications != null && notificationModel.data!.unreadNotifications!.isNotEmpty) {
          for (int i = 0; i < notificationModel.data!.unreadNotifications!.length; i++) {
            unReadNotificationList.add(notificationModel.data!.unreadNotifications![i]);
          }
        }

        isLoading.value = false;


      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${notificationModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }


}
