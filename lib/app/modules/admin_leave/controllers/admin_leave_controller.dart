import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_radio_button/custom_radio_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_approve_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_pending_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_rejected_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class AdminLeaveController extends GetxController {
  TabController? tabController;
  int selectedIndex = 0;
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  RxList<PendingLeaveData> pendingLeaveList = <PendingLeaveData>[].obs;
  RxList<ApproveLeaveData> approveLeaveList = <ApproveLeaveData>[].obs;
  RxList<RejectedLeaveData> rejectedLeaveList = <RejectedLeaveData>[].obs;

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

  RxString selectedOption = "P".obs;
  RxBool saveLoader = false.obs;

  Future<AdminPendingLeaveResponseModel?> getAdminPendingLeave() async {
    pendingLeaveList.clear();
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getAdminPendingLeaveList,
        header: GlobalVariable.header,
      );

      AdminPendingLeaveResponseModel adminPendingLeaveResponseModel =
          AdminPendingLeaveResponseModel.fromJson(response);
      if (adminPendingLeaveResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminPendingLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminPendingLeaveResponseModel.data!.length;
              i++) {
            pendingLeaveList.add(adminPendingLeaveResponseModel.data![i]);
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

    return AdminPendingLeaveResponseModel();
  }

  Future<AdminApproveLeaveResponseModel?> getAdminApproveLeave(
      {required bool isLoader}) async {
    approveLeaveList.clear();
    try {
      if (isLoader) {
        loadingController.isLoading = true;
      }

      final response = await BaseClient().getData(
        url: InfixApi.getAdminApproveLeaveList,
        header: GlobalVariable.header,
      );

      AdminApproveLeaveResponseModel adminApproveLeaveResponseModel =
          AdminApproveLeaveResponseModel.fromJson(response);
      if (adminApproveLeaveResponseModel.success == true) {
        if (isLoader) {
          loadingController.isLoading = false;
        }
        if (adminApproveLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminApproveLeaveResponseModel.data!.length;
              i++) {
            approveLeaveList.add(adminApproveLeaveResponseModel.data![i]);
          }
        }
      }
    } catch (e, t) {
      if (isLoader) {
        loadingController.isLoading = false;
      }
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      if (isLoader) {
        loadingController.isLoading = false;
      }
    }

    return AdminApproveLeaveResponseModel();
  }

  Future<AdminRejectedLeaveResponseModel?> getAdminRejectedLeave(
      {required bool isLoader}) async {
    rejectedLeaveList.clear();
    try {
      if (isLoader) {
        loadingController.isLoading = true;
      }
      final response = await BaseClient().getData(
        url: InfixApi.getAdminRejectedLeaveList,
        header: GlobalVariable.header,
      );

      AdminRejectedLeaveResponseModel adminRejectedLeaveResponseModel =
          AdminRejectedLeaveResponseModel.fromJson(response);
      if (adminRejectedLeaveResponseModel.success == true) {
        if (isLoader) {
          loadingController.isLoading = false;
        }
        if (adminRejectedLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminRejectedLeaveResponseModel.data!.length;
              i++) {
            rejectedLeaveList.add(adminRejectedLeaveResponseModel.data![i]);
          }
        }
      }
    } catch (e, t) {
      if (isLoader) {
        loadingController.isLoading = false;
      }
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      if (isLoader) {
        loadingController.isLoading = false;
      }
    }

    return AdminRejectedLeaveResponseModel();
  }

  void updateLeaveStatus(
      {required int leaveId,
      required String currentStatus,
      required String previousStatus,
      required int index}) async {
    try {
      saveLoader.value = true;
      final res = await BaseClient().postData(
        url: InfixApi.adminLeaveStatusUpdate(
            leaveId: leaveId, statusType: currentStatus),
        header: GlobalVariable.header,
      );

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(res);
      if (postRequestResponseModel.success == true) {
        saveLoader.value = false;

        if (previousStatus == 'P' && currentStatus == 'A') {
          approveLeaveList.add(
            ApproveLeaveData(
              id: pendingLeaveList[index].id,
              fullName: pendingLeaveList[index].fullName,
              applyDate: pendingLeaveList[index].applyDate,
              leaveTo: pendingLeaveList[index].leaveTo,
              leaveFrom: pendingLeaveList[index].leaveFrom,
              file: pendingLeaveList[index].file,
              type: pendingLeaveList[index].type,
              approveStatus: currentStatus,
            ),
          );
          pendingLeaveList.removeAt(index);
        } else if (previousStatus == 'P' && currentStatus == 'C') {
          rejectedLeaveList.add(
            RejectedLeaveData(
              id: pendingLeaveList[index].id,
              fullName: pendingLeaveList[index].fullName,
              applyDate: pendingLeaveList[index].applyDate,
              leaveTo: pendingLeaveList[index].leaveTo,
              leaveFrom: pendingLeaveList[index].leaveFrom,
              file: pendingLeaveList[index].file,
              type: pendingLeaveList[index].type,
              approveStatus: currentStatus,
            ),
          );
          pendingLeaveList.removeAt(index);
        } else if (previousStatus == 'A' && currentStatus == 'P') {
          pendingLeaveList.add(
            PendingLeaveData(
              id: pendingLeaveList[index].id,
              fullName: pendingLeaveList[index].fullName,
              applyDate: pendingLeaveList[index].applyDate,
              leaveTo: pendingLeaveList[index].leaveTo,
              leaveFrom: pendingLeaveList[index].leaveFrom,
              file: pendingLeaveList[index].file,
              type: pendingLeaveList[index].type,
              approveStatus: currentStatus,
            ),
          );
          approveLeaveList.removeAt(index);
        } else if (previousStatus == 'A' && currentStatus == 'C') {
          rejectedLeaveList.add(
            RejectedLeaveData(
              id: pendingLeaveList[index].id,
              fullName: pendingLeaveList[index].fullName,
              applyDate: pendingLeaveList[index].applyDate,
              leaveTo: pendingLeaveList[index].leaveTo,
              leaveFrom: pendingLeaveList[index].leaveFrom,
              file: pendingLeaveList[index].file,
              type: pendingLeaveList[index].type,
              approveStatus: currentStatus,
            ),
          );
          approveLeaveList.removeAt(index);
        } else if (previousStatus == 'C' && currentStatus == 'P') {
          pendingLeaveList.add(
            PendingLeaveData(
              id: pendingLeaveList[index].id,
              fullName: pendingLeaveList[index].fullName,
              applyDate: pendingLeaveList[index].applyDate,
              leaveTo: pendingLeaveList[index].leaveTo,
              leaveFrom: pendingLeaveList[index].leaveFrom,
              file: pendingLeaveList[index].file,
              type: pendingLeaveList[index].type,
              approveStatus: currentStatus,
            ),
          );
          rejectedLeaveList.removeAt(index);
        } else if (previousStatus == 'C' && currentStatus == 'A') {
          approveLeaveList.add(
            ApproveLeaveData(
              id: pendingLeaveList[index].id,
              fullName: pendingLeaveList[index].fullName,
              applyDate: pendingLeaveList[index].applyDate,
              leaveTo: pendingLeaveList[index].leaveTo,
              leaveFrom: pendingLeaveList[index].leaveFrom,
              file: pendingLeaveList[index].file,
              type: pendingLeaveList[index].type,
              approveStatus: currentStatus,
            ),
          );
          rejectedLeaveList.removeAt(index);
        }

        Get.back();
        showBasicSuccessSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong.');
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong.');
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }
  }



  void showPendingListDetailsBottomSheet({
    required int index,
    required String reason,
    required Function() onTap,
    required String leaveType,
    required String applyDate,
    required String leaveFrom,
    required String leaveTo,
    required String file,
  }) {
    Get.bottomSheet(
      Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.7,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpacing,
                Text(
                  "${"Reason".tr}: $reason",
                  style: AppTextStyle.fontSize14BlackW500,
                ),
                20.verticalSpacing,
                BottomSheetTile(
                  title: "Leave Type".tr,
                  value: leaveType,
                  color: AppColors.homeworkWidgetColor,
                ),
                BottomSheetTile(
                  title: "Apply Date".tr,
                  value: applyDate,
                ),
                BottomSheetTile(
                  title: "Leave From".tr,
                  value: leaveFrom,
                  color: AppColors.homeworkWidgetColor,
                ),
                BottomSheetTile(
                  title: "Leave To".tr,
                  value: leaveTo,
                ),
                10.verticalSpacing,
                InkWell(
                  onTap: () => fileDownload(url: file, title: file.toString()),
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text("Attached File".tr, style: AppTextStyle.textStyle12WhiteW400,),
                        10.horizontalSpacing,
                        Image.asset(ImagePath.download, scale: 5, color: Colors.white,),
                      ],
                    ),
                  ),
                ),
                30.verticalSpacing,
                 Text(
                  "Leave Status".tr,
                  style: AppTextStyle.fontSize14BlackW500,
                ),
                CustomRadioButton(
                  title: "Pending".tr,
                  value: "P",
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    selectedOption.value = value!;
                  },
                  activeColor: AppColors.primaryColor,
                ),
                CustomRadioButton(
                  title: "Approved".tr,
                  value: "A",
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    selectedOption.value = value!;
                    debugPrint("Value is $selectedOption");
                  },
                  activeColor: AppColors.primaryColor,
                ),
                CustomRadioButton(
                  title: "Rejected".tr,
                  value: "C",
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    selectedOption.value = value!;
                    debugPrint("Value is $selectedOption");
                  },
                  activeColor: AppColors.primaryColor,
                ),
                20.verticalSpacing,
                Obx(
                  () => saveLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ))
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: onTap,
                        ),
                ),
                30.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }


  void fileDownload({required String url, required String title}) {
    url == ''
        ? showBasicFailedSnackBar(
      message: 'No File Available'.tr,
    )
        : FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  @override
  void onInit() {
    getAdminPendingLeave();
    getAdminApproveLeave(isLoader: false);
    getAdminRejectedLeave(isLoader: false);
    super.onInit();
  }
}
