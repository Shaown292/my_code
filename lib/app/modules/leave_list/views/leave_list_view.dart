import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/applied_leave_details_tile/applied_leave_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import '../controllers/leave_list_controller.dart';

class LeaveListView extends GetView<LeaveListController> {
  const LeaveListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.status.length,
      child: InfixEduScaffold(
        title: "Leave List".tr,
        body: SingleChildScrollView(
          child: CustomBackground(
            customWidget: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.globalRxVariableController.roleId.value != 4
                      ? Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "My Remaining Leave".tr,
                                  style: AppTextStyle.fontSize14BlackW500,
                                ),
                                10.verticalSpacing,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.remainingLeaveList.length,
                                  itemBuilder: (context, index) {
                                    return BottomSheetTile(
                                      title: controller
                                          .remainingLeaveList[index].leaveType,
                                      value: controller
                                          .remainingLeaveList[index].remainingDays
                                          .toString(),
                                      color: index % 2 == 0
                                          ? AppColors.homeworkWidgetColor
                                          : Colors.white,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  controller.globalRxVariableController.roleId.value != 4
                      ? 30.verticalSpacing
                      : 0.verticalSpacing,
                  controller.globalRxVariableController.roleId.value != 4
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Leave List".tr,
                            style: AppTextStyle.blackFontSize14W400,
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TabBar(
                      labelColor: AppColors.profileValueColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
                      indicatorColor: AppColors.profileIndicatorColor,
                      controller: controller.tabController,
                      tabs: List.generate(
                        controller.status.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            controller.status[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpacing,
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ///Pending
                        controller.loadingController.isLoading
                            ? const LoadingWidget()
                            : controller.pendingList.isNotEmpty
                                ? RefreshIndicator(
                                    color: AppColors.primaryColor,
                                    onRefresh: () async {
                                      controller.pendingList.clear();
                                      controller.remainingLeaveList.clear();
                                     if(controller.globalRxVariableController.roleId.value == 2){
                                       controller.getRemainingLeave(
                                         studentId: controller
                                             .globalRxVariableController
                                             .studentId
                                             .value!,
                                       );
                                       controller.getAllLeaveList(controller
                                           .globalRxVariableController
                                           .studentId
                                           .value!);
                                     }
                                     else{
                                       controller.getAllLeaveList(1);
                                     }
                                    },
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.pendingList.length,
                                        itemBuilder: (context, index) {
                                          return AppliedLeaveDetailsTile(
                                            leaveType: controller
                                                .pendingList[index].leaveType,
                                            applyDate: controller
                                                .pendingList[index].applyDate,
                                            leaveFrom: controller
                                                .pendingList[index].from,
                                            leaveTo:
                                                controller.pendingList[index].to,
                                            status: "${controller
        .pendingList[index].status} $index",
                                            statusColor:
                                                AppColors.activeStatusYellowColor,
                                            onTap: () {
                                              controller
                                                  .showPendingListDetailsBottomSheet(
                                                      index: index);
                                            },
                                          );
                                        }),
                                  )
                                : const Center(
                                    child: SingleChildScrollView(
                                      child: NoDataAvailableWidget(),
                                    ),
                                  ),

                        /// Approved

                        controller.loadingController.isLoading
                            ? const LoadingWidget()
                            : controller.approvedList.isNotEmpty
                                ? RefreshIndicator(
                                    color: AppColors.primaryColor,
                                    onRefresh: () async {
                                      controller.remainingLeaveList.clear();
                                      controller.approvedList.clear();
                                      if(controller.globalRxVariableController.roleId.value == 2){
                                        controller.getRemainingLeave(
                                          studentId: controller
                                              .globalRxVariableController
                                              .studentId
                                              .value!,
                                        );
                                        controller.getAllLeaveList(controller
                                            .globalRxVariableController
                                            .studentId
                                            .value!);
                                      }
                                      else{
                                        controller.getAllLeaveList(1);
                                      }
                                    },
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.approvedList.length,
                                        itemBuilder: (context, index) {
                                          return AppliedLeaveDetailsTile(
                                            leaveType: controller
                                                .approvedList[index]
                                                .leaveType,
                                            applyDate: controller
                                                .approvedList[index]
                                                .applyDate,
                                            leaveFrom: controller
                                                .approvedList[index].from,
                                            leaveTo: controller
                                                .approvedList[index].to,
                                            status: controller
                                                .approvedList[index].status,
                                            statusColor:
                                                AppColors.primaryColor,
                                            onTap: () {
                                              controller
                                                  .showApprovedListDetailsBottomSheet(
                                                      index: index);
                                            },
                                          );
                                        }),
                                  )
                                : const Center(
                                    child: SingleChildScrollView(
                                      child: NoDataAvailableWidget(),
                                    ),
                                  ),

                        /// Cancelled

                        controller.loadingController.isLoading
                            ? const LoadingWidget()
                            : controller.cancelledList.isNotEmpty
                                ? RefreshIndicator(
                                    color: AppColors.primaryColor,
                                    onRefresh: () async {
                                      controller.remainingLeaveList.clear();
                                      controller.cancelledList.clear();
                                      if(controller.globalRxVariableController.roleId.value == 2){
                                        controller.getRemainingLeave(
                                          studentId: controller
                                              .globalRxVariableController
                                              .studentId
                                              .value!,
                                        );
                                        controller.getAllLeaveList(controller
                                            .globalRxVariableController
                                            .studentId
                                            .value!);
                                      }
                                      else{
                                        controller.getAllLeaveList(1);
                                      }
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.cancelledList.length,
                                      itemBuilder: (context, index) {
                                        return AppliedLeaveDetailsTile(
                                          leaveType: controller
                                              .cancelledList[index].leaveType,
                                          applyDate: controller
                                              .cancelledList[index].applyDate,
                                          leaveFrom: controller
                                              .cancelledList[index].from,
                                          leaveTo:
                                              controller.cancelledList[index].to,
                                          status: controller
                                              .cancelledList[index].status,
                                          statusColor:
                                              AppColors.activeStatusRedColor,
                                          onTap: () {
                                            controller
                                                .showRejectedListDetailsBottomSheet(
                                                    index: index);
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : const Center(
                                    child: SingleChildScrollView(
                                      child: NoDataAvailableWidget(),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                  20.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
