import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_leave/controllers/admin_leave_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/applied_leave_details_tile/applied_leave_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
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
                          ? const Column(
                              children: [
                                LoadingWidget(),
                              ],
                            )
                          : controller.pendingLeaveList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    controller.getAdminPendingLeave();
                                  },
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.pendingLeaveList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          AppliedLeaveDetailsTile(
                                            leaveType: controller
                                                .pendingLeaveList[index].type,
                                            applyDate: controller
                                                .pendingLeaveList[index]
                                                .applyDate,
                                            leaveFrom: controller
                                                .pendingLeaveList[index]
                                                .leaveFrom,
                                            leaveTo: controller
                                                .pendingLeaveList[index]
                                                .leaveTo,
                                            approveStatus: controller
                                                .pendingLeaveList[index]
                                                .approveStatus,
                                            statusColor: AppColors
                                                .activeStatusYellowColor,
                                            onTap: () {
                                              controller
                                                  .showPendingListDetailsBottomSheet(
                                                index: index,
                                                reason: controller
                                                        .pendingLeaveList[index]
                                                        .reason ??
                                                    "",
                                                onTap: () {
                                                  controller.updateLeaveStatus(
                                                    leaveId: controller
                                                        .pendingLeaveList[index]
                                                        .id!,
                                                    currentStatus: controller
                                                        .selectedOption.value,
                                                    previousStatus: controller
                                                        .pendingLeaveList[index]
                                                        .approveStatus!,
                                                    index: index,
                                                  );
                                                },
                                                leaveType: controller
                                                        .pendingLeaveList[index]
                                                        .type ??
                                                    '',
                                                applyDate: controller
                                                        .pendingLeaveList[index]
                                                        .applyDate ??
                                                    '',
                                                leaveFrom: controller
                                                        .pendingLeaveList[index]
                                                        .leaveFrom ??
                                                    '',
                                                leaveTo: controller
                                                        .pendingLeaveList[index]
                                                        .leaveTo ??
                                                    '',
                                                file: controller
                                                        .pendingLeaveList[index]
                                                        .file ??
                                                    '',
                                              );
                                            },
                                          )
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
                          ? const Column(
                              children: [
                                LoadingWidget(),
                              ],
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
                                        return Column(
                                          children: [
                                            AppliedLeaveDetailsTile(
                                              leaveType: controller
                                                  .approveLeaveList[index].type,
                                              applyDate: controller
                                                  .approveLeaveList[index]
                                                  .applyDate,
                                              leaveFrom: controller
                                                  .approveLeaveList[index]
                                                  .leaveFrom,
                                              leaveTo: controller
                                                  .approveLeaveList[index]
                                                  .leaveTo,
                                              approveStatus: controller
                                                  .approveLeaveList[index]
                                                  .approveStatus,
                                              statusColor: AppColors
                                                  .activeStatusGreenColor,
                                              onTap: () {
                                                controller
                                                    .showPendingListDetailsBottomSheet(
                                                  index: index,
                                                  reason: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .reason ??
                                                      "",
                                                  onTap: () {
                                                    controller
                                                        .updateLeaveStatus(
                                                      leaveId: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .id!,
                                                      currentStatus: controller
                                                          .selectedOption.value,
                                                      previousStatus: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .approveStatus!,
                                                      index: index,
                                                    );
                                                  },
                                                  leaveType: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .type ??
                                                      '',
                                                  applyDate: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .applyDate ??
                                                      '',
                                                  leaveFrom: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .leaveFrom ??
                                                      '',
                                                  leaveTo: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .leaveTo ??
                                                      '',
                                                  file: controller
                                                          .approveLeaveList[
                                                              index]
                                                          .file ??
                                                      '',
                                                );
                                              },
                                            )
                                          ],
                                        );
                                      }),
                                )
                              : const NoDataAvailableWidget(),
                    ),

                    /// Rejected

                    Obx(
                      () => controller.loadingController.isLoading
                          ? const Column(
                              children: [
                                LoadingWidget(),
                              ],
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
                                      return Column(
                                        children: [
                                          AppliedLeaveDetailsTile(
                                            leaveType: controller
                                                .rejectedLeaveList[index].type,
                                            applyDate: controller
                                                .rejectedLeaveList[index]
                                                .applyDate,
                                            leaveFrom: controller
                                                .rejectedLeaveList[index]
                                                .leaveFrom,
                                            leaveTo: controller
                                                .rejectedLeaveList[index]
                                                .leaveTo,
                                            approveStatus: controller
                                                .rejectedLeaveList[index]
                                                .approveStatus,
                                            statusColor:
                                                AppColors.activeStatusRedColor,
                                            onTap: () {
                                              controller
                                                  .showPendingListDetailsBottomSheet(
                                                index: index,
                                                reason: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .reason ??
                                                    "",
                                                onTap: () {
                                                  controller.updateLeaveStatus(
                                                    leaveId: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .id!,
                                                    currentStatus: controller
                                                        .selectedOption.value,
                                                    previousStatus: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .approveStatus!,
                                                    index: index,
                                                  );
                                                },
                                                leaveType: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .type ??
                                                    '',
                                                applyDate: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .applyDate ??
                                                    '',
                                                leaveFrom: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .leaveFrom ??
                                                    '',
                                                leaveTo: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .leaveTo ??
                                                    '',
                                                file: controller
                                                        .rejectedLeaveList[
                                                            index]
                                                        .file ??
                                                    '',
                                              );
                                            },
                                          )
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
