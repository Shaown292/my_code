import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_approve_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_pending_leave_responseModel.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_rejected_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class AdminLeaveController extends GetxController {
  TabController? tabController;
  int selectedIndex = 0;
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<PendingLeaveData> pendingLeaveList = [];
  List<ApproveLeaveData> approveLeaveList = [];
  List<RejectedLeaveData> rejectedLeaveList = [];

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

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

  Future<AdminApproveLeaveResponseModel?> getAdminApproveLeave({required bool isLoader}) async {
    approveLeaveList.clear();
    try {
      if(isLoader){
        loadingController.isLoading = true;
      }

      final response = await BaseClient().getData(
        url: InfixApi.getAdminApproveLeaveList,
        header: GlobalVariable.header,
      );

      AdminApproveLeaveResponseModel adminApproveLeaveResponseModel =
      AdminApproveLeaveResponseModel.fromJson(response);
      if (adminApproveLeaveResponseModel.success == true) {
        if(isLoader){
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
      if(isLoader){
          loadingController.isLoading = false;
        }
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      if(isLoader){
          loadingController.isLoading = false;
        }
    }

    return AdminApproveLeaveResponseModel();
  }

  Future<AdminRejectedLeaveResponseModel?> getAdminRejectedLeave({required bool isLoader}) async {
    rejectedLeaveList.clear();
    try {

      if(isLoader){
        loadingController.isLoading = true;
      }
      final response = await BaseClient().getData(
        url: InfixApi.getAdminRejectedLeaveList,
        header: GlobalVariable.header,
      );

      AdminRejectedLeaveResponseModel adminRejectedLeaveResponseModel =
      AdminRejectedLeaveResponseModel.fromJson(response);
      if (adminRejectedLeaveResponseModel.success == true) {
        if(isLoader){
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
      if(isLoader){
          loadingController.isLoading = false;
        }
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      if(isLoader){
          loadingController.isLoading = false;
        }
    }

    return AdminRejectedLeaveResponseModel();
  }

  void updateLeaveStatus({required int leaveId, required String statusType}) async {

    try {
      loadingController.isLoading = true;
      final res = await BaseClient().postData(
        url: InfixApi.adminLeaveStatusUpdate(leaveId: leaveId, statusType: statusType),
        header: GlobalVariable.header,
        // payload: {
        //   "email": email,
        //   "password": password
        // },
      );

      PostRequestResponseModel postRequestResponseModel = PostRequestResponseModel.fromJson(res);
      if (postRequestResponseModel.success == true) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: postRequestResponseModel.message ?? 'Something went wrong.');

      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: postRequestResponseModel.message ?? 'Something went wrong.');
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  void showPendingListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text(
                "Reason: something}",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Apply Date",
                value: "",
              ),
              const BottomSheetTile(
                title: "Leave From",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Leave To",
                value: "",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  void showApprovedListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text(
                "Reason: something",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Apply Date",
                value: "",
              ),
              const BottomSheetTile(
                title: "Leave From",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Leave To",
                value: "",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  void showRejectedListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text(
                "Reason: asdjas",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Apply Date",
                value: "",
              ),
              const BottomSheetTile(
                title: "Leave From",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Leave To",
                value: "",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    getAdminPendingLeave();
    getAdminApproveLeave(isLoader: false);
    getAdminRejectedLeave(isLoader: false);
    super.onInit();
  }
}
