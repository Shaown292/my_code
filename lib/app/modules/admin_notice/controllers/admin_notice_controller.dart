import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:get/get.dart';

class AdminNoticeController extends GetxController {
  void showNoticeDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.45,
        color: bottomSheetBackgroundColor,
        child: const Center(
          child: Text(
            "allNoticeList[index].noticeMessage",
            style: AppTextStyle.fontSize13BlackW400,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }
}
