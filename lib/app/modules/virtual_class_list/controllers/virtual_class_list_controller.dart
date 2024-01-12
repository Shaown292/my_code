import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/online_class/zoom/zoom_meeting_list_response_model.dart';
import 'package:get/get.dart';

class VirtualClassListController extends GetxController {

  RxList<ZoomMeetingList> zoomMeetingList = <ZoomMeetingList>[].obs;
  RxBool zoomMeetingLoader = false.obs;


  /// Get Zoom Meeting List
  Future<ZoomMeetingListResponseModel> getZoomMeetingList() async {
    try {
      zoomMeetingList.clear();

      zoomMeetingLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.zoomMeetingList,
        header: GlobalVariable.header,
      );

      ZoomMeetingListResponseModel zoomMeetingListResponseModel = ZoomMeetingListResponseModel.fromJson(response);

      if (zoomMeetingListResponseModel.success == true) {
        zoomMeetingLoader.value = false;
        if (zoomMeetingListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
          i < zoomMeetingListResponseModel.data!.length;
          i++) {
            zoomMeetingList.add(zoomMeetingListResponseModel.data![i]);
          }
        }
      } else {
        zoomMeetingLoader.value = false;
        showBasicFailedSnackBar(
          message: zoomMeetingListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      Get.back();
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      zoomMeetingLoader.value = false;
    }

    return ZoomMeetingListResponseModel();
  }

  @override
  void onInit() {
    getZoomMeetingList();
    super.onInit();
  }

}
