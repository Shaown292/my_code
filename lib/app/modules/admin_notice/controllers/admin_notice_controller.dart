import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_notice_model/admin_staff_notice_response_model.dart';
import 'package:get/get.dart';

class AdminNoticeController extends GetxController {
  LoadingController loadingController = Get.find();

  RxList<AdminStaffNoticeData> adminStaffNoticeList =
      <AdminStaffNoticeData>[].obs;

  Future<AdminStaffNoticeResponseModel> getAdminStaffNotice() async {
    try {
      adminStaffNoticeList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: GlobalVariable.roleId == 1 ? InfixApi.getAdminStaffNoticeList : InfixApi.getTeacherNoticeList, header: GlobalVariable.header);

      AdminStaffNoticeResponseModel adminStaffNoticeResponseModel =
          AdminStaffNoticeResponseModel.fromJson(response);

      if (adminStaffNoticeResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminStaffNoticeResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < adminStaffNoticeResponseModel.data!.length; i++) {
            adminStaffNoticeList.add(adminStaffNoticeResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminStaffNoticeResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminStaffNoticeResponseModel();
  }

  void showNoticeDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.45,
        color: bottomSheetBackgroundColor,
        child: Center(
          child: Text(
            adminStaffNoticeList[index].noticeMessage ?? 'No notice available.',
            style: AppTextStyle.fontSize13BlackW400,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    getAdminStaffNotice();
    super.onInit();
  }
}
