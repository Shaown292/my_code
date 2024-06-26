import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/notice_list_response_model/notice_list_response_model.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';

class NoticeController extends GetxController {
  LoadingController loadingController = Get.find();
  List<AllNotices> allNoticeList = [];

  Future<NoticeListResponseModel?> getAllNoticeList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.studentAllNotice,
        header: GlobalVariable.header,
      );

      NoticeListResponseModel noticeListResponseModel =
          NoticeListResponseModel.fromJson(response);
      if (noticeListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (noticeListResponseModel.data!.allNotices!.isNotEmpty) {
          for (int i = 0;
              i < noticeListResponseModel.data!.allNotices!.length;
              i++) {
            allNoticeList.add(noticeListResponseModel.data!.allNotices![i]);
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return NoticeListResponseModel();
  }

  void showNoticeDetailsBottomSheet({required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.45,
        color: bottomSheetBackgroundColor,
        child: allNoticeList[index].noticeMessage != null
            ? Center(
                child: Text(
                  allNoticeList[index].noticeMessage ?? "",
                  style: AppTextStyle.fontSize13BlackW400,
                  textAlign: TextAlign.justify,
                ),
              )
            : const Center(
                child: Text(
                  "No Details Available",
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
              ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    getAllNoticeList();
    super.onInit();
  }
}
