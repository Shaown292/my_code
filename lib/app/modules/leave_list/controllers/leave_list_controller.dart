import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/remaining_leave_response_model/remaining_leave_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_apply_leave_model/leave_list_response_model.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class LeaveListController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  TabController? tabController;
  int selectedIndex = 0;
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<LeaveListData> leaveList = [];
  List<LeaveListPending> pendingList = [];
  List<LeaveListRejected> rejectedList = [];
  List<LeaveListApproved> approvedList = [];
  List<RemainingLeaveListData> remainingLeaveList = [];

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

  Future<LeaveListResponseModel?> getAllNoticeList(
      {required int studentId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentLeaveList(studentId),
        header: GlobalVariable.header,
      );

      LeaveListResponseModel leaveListResponseModel =
          LeaveListResponseModel.fromJson(response);
      if (leaveListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (leaveListResponseModel.data!.pending!.isNotEmpty) {
          for (int i = 0;
              i < leaveListResponseModel.data!.pending!.length;
              i++) {
            pendingList.add(leaveListResponseModel.data!.pending![i]);
          }
        }

        if (leaveListResponseModel.data!.rejected!.isNotEmpty) {
          for (int i = 0;
              i < leaveListResponseModel.data!.rejected!.length;
              i++) {
            rejectedList.add(leaveListResponseModel.data!.rejected![i]);
          }
        }

        if (leaveListResponseModel.data!.approved!.isNotEmpty) {
          for (int i = 0;
              i < leaveListResponseModel.data!.approved!.length;
              i++) {
            approvedList.add(leaveListResponseModel.data!.approved![i]);
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
    return LeaveListResponseModel();
  }

  Future<RemainingLeaveResponseModel?> getRemainingLeave(
      {required int studentId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentRemainingLeave(studentId),
        header: GlobalVariable.header,
      );

      RemainingLeaveResponseModel remainingLeaveResponseModel =
          RemainingLeaveResponseModel.fromJson(response);
      if (remainingLeaveResponseModel.success == true) {
        loadingController.isLoading = false;
        if (remainingLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < remainingLeaveResponseModel.data!.length; i++) {
            remainingLeaveList.add(remainingLeaveResponseModel.data![i]);
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

    return RemainingLeaveResponseModel();
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
              Text(
                "Reason: ${pendingList[index].reason}",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              BottomSheetTile(
                title: "Leave Type",
                value: pendingList[index].leaveType,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Apply Date",
                value: pendingList[index].applyDate,
              ),
              BottomSheetTile(
                title: "Leave From",
                value: pendingList[index].from,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Leave To",
                value: pendingList[index].to,
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
              Text(
                "Reason: ${approvedList[index].reason}",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              BottomSheetTile(
                title: "Leave Type",
                value: approvedList[index].leaveType,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Apply Date",
                value: approvedList[index].applyDate,
              ),
              BottomSheetTile(
                title: "Leave From",
                value: approvedList[index].from,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Leave To",
                value: approvedList[index].to,
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
              Text(
                "Reason: ${rejectedList[index].reason}",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              BottomSheetTile(
                title: "Leave Type",
                value: rejectedList[index].leaveType,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Apply Date",
                value: rejectedList[index].applyDate,
              ),
              BottomSheetTile(
                title: "Leave From",
                value: rejectedList[index].from,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Leave To",
                value: rejectedList[index].to,
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    if (homeController.studentRecordList.isNotEmpty) {
      getAllNoticeList(
        studentId: globalRxVariableController.studentId.value!,
      );
      getRemainingLeave(
        studentId: globalRxVariableController.studentId.value!,
      );
    }
    super.onInit();
  }
}
