import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_leave/controllers/admin_leave_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/applied_leave_details_tile/applied_leave_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_approve_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_pending_leave_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_leave_model/admin_rejected_leave_response_model.dart';
import 'package:get/get.dart';

class AdminLeaveView extends GetView<AdminLeaveController> {
  const AdminLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.status.length,
      child: InfixEduScaffold(
        title: "Leave List",
        body: CustomBackground(
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Obx(
                      () => controller.loadingController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : controller.pendingLeaveList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    controller.getAdminPendingLeave();
                                  },
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.pendingLeaveList.length,
                                    itemBuilder: (context, index) {
                                      PendingLeaveData pendingData =
                                          controller.pendingLeaveList[index];
                                      return Column(
                                        children: [
                                          AppliedLeaveDetailsTile(
                                            leaveType: pendingData.type,
                                            applyDate: pendingData.applyDate,
                                            leaveFrom: pendingData.leaveFrom,
                                            leaveTo: pendingData.leaveTo,
                                            status:
                                                pendingData.approveStatus,
                                            statusColor: AppColors
                                                .activeStatusYellowColor,
                                            onTap: () {
                                              controller
                                                  .showPendingListDetailsBottomSheet(
                                                index: index,
                                                reason:
                                                    pendingData.reason ?? "",
                                                onTap: () {
                                                  controller.updateLeaveStatus(
                                                    leaveId: pendingData.id!,
                                                    currentStatus: controller
                                                        .selectedOption.value,
                                                    previousStatus: pendingData
                                                        .approveStatus!,
                                                    index: index,
                                                  );
                                                },
                                                leaveType:
                                                    pendingData.type ?? '',
                                                applyDate:
                                                    pendingData.applyDate ?? '',
                                                leaveFrom:
                                                    pendingData.leaveFrom ?? '',
                                                leaveTo:
                                                    pendingData.leaveTo ?? '',
                                                file: pendingData.file ?? '',
                                              );
                                            },
                                          ),
                                          20.verticalSpacing,
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const NoDataAvailableWidget(),
                    ),

                    /// Approved

                    Obx(
                      () => controller.loadingController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : controller.approveLeaveList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    controller.getAdminApproveLeave(
                                        isLoader: true);
                                  },
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.approveLeaveList.length,
                                      itemBuilder: (context, index) {
                                        ApproveLeaveData approveLeaveData =
                                            controller.approveLeaveList[index];
                                        return Column(
                                          children: [
                                            AppliedLeaveDetailsTile(
                                              leaveType: approveLeaveData.type,
                                              applyDate:
                                                  approveLeaveData.applyDate,
                                              leaveFrom:
                                                  approveLeaveData.leaveFrom,
                                              leaveTo: approveLeaveData.leaveTo,
                                              status: approveLeaveData
                                                  .approveStatus,
                                              statusColor: AppColors
                                                  .activeStatusGreenColor,
                                              onTap: () {
                                                controller
                                                    .showPendingListDetailsBottomSheet(
                                                  index: index,
                                                  reason:
                                                      approveLeaveData.reason ??
                                                          "",
                                                  onTap: () {
                                                    controller
                                                        .updateLeaveStatus(
                                                      leaveId:
                                                          approveLeaveData.id!,
                                                      currentStatus: controller
                                                          .selectedOption.value,
                                                      previousStatus:
                                                          approveLeaveData
                                                              .approveStatus!,
                                                      index: index,
                                                    );
                                                  },
                                                  leaveType:
                                                      approveLeaveData.type ??
                                                          '',
                                                  applyDate: approveLeaveData
                                                          .applyDate ??
                                                      '',
                                                  leaveFrom: approveLeaveData
                                                          .leaveFrom ??
                                                      '',
                                                  leaveTo: approveLeaveData
                                                          .leaveTo ??
                                                      '',
                                                  file: approveLeaveData.file ??
                                                      '',
                                                );
                                              },
                                            ),
                                            20.verticalSpacing,
                                          ],
                                        );
                                      }),
                                )
                              : const NoDataAvailableWidget(),
                    ),

                    /// Rejected

                    Obx(
                      () => controller.loadingController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : controller.rejectedLeaveList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    controller.getAdminRejectedLeave(
                                        isLoader: true);
                                  },
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.rejectedLeaveList.length,
                                    itemBuilder: (context, index) {
                                      RejectedLeaveData rejectedLeaveData =
                                          controller.rejectedLeaveList[index];
                                      return Column(
                                        children: [
                                          AppliedLeaveDetailsTile(
                                            leaveType: rejectedLeaveData.type,
                                            applyDate:
                                                rejectedLeaveData.applyDate,
                                            leaveFrom:
                                                rejectedLeaveData.leaveFrom,
                                            leaveTo: rejectedLeaveData.leaveTo,
                                            status:
                                                rejectedLeaveData.approveStatus,
                                            statusColor:
                                                AppColors.activeStatusRedColor,
                                            onTap: () {
                                              controller
                                                  .showPendingListDetailsBottomSheet(
                                                index: index,
                                                reason:
                                                    rejectedLeaveData.reason ??
                                                        "",
                                                onTap: () {
                                                  controller.updateLeaveStatus(
                                                    leaveId:
                                                        rejectedLeaveData.id!,
                                                    currentStatus: controller
                                                        .selectedOption.value,
                                                    previousStatus:
                                                        rejectedLeaveData
                                                            .approveStatus!,
                                                    index: index,
                                                  );
                                                },
                                                leaveType:
                                                    rejectedLeaveData.type ??
                                                        '',
                                                applyDate: rejectedLeaveData
                                                        .applyDate ??
                                                    '',
                                                leaveFrom: rejectedLeaveData
                                                        .leaveFrom ??
                                                    '',
                                                leaveTo:
                                                    rejectedLeaveData.leaveTo ??
                                                        '',
                                                file: rejectedLeaveData.file ??
                                                    '',
                                              );
                                            },
                                          ),
                                          20.verticalSpacing,
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const NoDataAvailableWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
