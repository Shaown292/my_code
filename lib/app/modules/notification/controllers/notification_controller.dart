
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/database/auth_database.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/default_response_model/default_response_model.dart';
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
  LoadingController loadingController = Get.find();


 RxList unReadNotificationList = [].obs;
 // int unreadNotificationCount = 0;

  void fetchNotifications() async {

    isLoading.value = true;

    try {
      final res = await BaseClient().getData(
        url: "https://spondan.com/infixedu/api/v2/all-notification-list",
        header: GlobalVariableController.header,

      );


      NotificationModel notificationModel = NotificationModel.fromJson(res);

      if (notificationModel.success == true) {
        AuthDatabase authDatabase = AuthDatabase.instance;
        authDatabase.saveUnReadNotification(unReadNotification: notificationModel.data?.unreadNotificationsCount ?? 0);
        notificationCountController.notificationCount.value = notificationModel.data?.unreadNotificationsCount ?? 0;
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

  void readAllNotifications() async {
    AuthDatabase authDatabase = AuthDatabase.instance;

    try{
      loadingController.isLoading = true;
      final response = await BaseClient().getData(url: InfixApi.readAllNotification(GlobalVariableController.roleId.toString()), header: GlobalVariableController.header,);

    DefaultResponseModel defaultResponseModel = DefaultResponseModel.fromJson(response);

      if(defaultResponseModel.success == true){
        unReadNotificationList.clear();
        notificationCountController.notificationCount.value = 0;
        authDatabase.saveUnReadNotification(unReadNotification: 0);
      }


    } catch(e, t){
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      loadingController.isLoading = false;
    }

  }

}
