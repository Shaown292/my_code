import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_apply_leave_model/leave_list_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';

class LeaveListController extends GetxController {
  TabController? tabController;
  int selectedIndex = 0;
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<LeaveListData> leaveList = [];
  List<LeaveListPending> pendingList = [];
  List<LeaveListRejected> rejectedList = [];
  List<LeaveListApproved> approvedList = [];

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

  void getAllNoticeList({required int studentId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentLeaveList(studentId),
        header: GlobalVariableController.header,
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
  }

  void showLeaveListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpacing,
              Text(
                "Reason: ${pendingList[index].reason}",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Leave To",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      Text(
                        pendingList[index].to ?? "",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      const Text(
                        "Leave Type",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      Text(
                        pendingList[index].leaveType ?? "",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Apply Date",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      Text(
                        pendingList[index].applyDate ?? "",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      const Text(
                        "Leave From",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                      10.verticalSpacing,
                      Text(
                        pendingList[index].from ?? "",
                        style: AppTextStyle.fontSize14lightViolateW400,
                      ),
                    ],
                  ),
                ],
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
      getAllNoticeList(studentId: GlobalVariableController.studentId!);
    }
    super.onInit();
  }
}
