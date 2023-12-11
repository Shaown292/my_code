import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/applied_leave_details_tile/applied_leave_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../controllers/te_leave_list_controller.dart';

class TeLeaveListView extends GetView<TeLeaveListController> {
  const TeLeaveListView({super.key});

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
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      AppliedLeaveDetailsTile(
                                        leaveType: "Sick Leave",
                                        applyDate: "10-01-2023",
                                        leaveFrom: "10-01-2023",
                                        leaveTo: "10-01-2023",
                                        status: "Approved",
                                        statusColor:
                                            AppColors.activeStatusYellowColor,
                                        onTap: () {
                                          controller
                                              .showPendingListDetailsBottomSheet(
                                            index: index,
                                            reason: "Hudai",
                                            leaveType: "Sick Leave",
                                            applyDate: "10-01-2023",
                                            leaveFrom: "10-01-2023",
                                            leaveTo: "10-01-2023",



                                          );
                                        },
                                      ),
                                      20.verticalSpacing,
                                    ],
                                  );
                                },
                              ),
                            ),
                    ),

                    /// Approved

                    Obx(
                      () => controller.loadingController.isLoading
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        AppliedLeaveDetailsTile(
                                          leaveType: "Sick Leave",
                                          applyDate: "10-01-2023",
                                          leaveFrom: "10-01-2023",
                                          leaveTo: "10-01-2023",
                                          status: "Approved",
                                          statusColor:
                                              AppColors.activeStatusGreenColor,
                                          onTap: () {
                                            controller
                                                .showPendingListDetailsBottomSheet(
                                              index: index,
                                              reason: "Hudai",
                                              leaveType: "Sick Leave",
                                              applyDate: "10-01-2023",
                                              leaveFrom: "10-01-2023",
                                              leaveTo: "10-01-2023",

                                            );
                                          },
                                        ),
                                        20.verticalSpacing,
                                      ],
                                    );
                                  }),
                            ),
                    ),

                    /// Rejected

                    Obx(
                      () => controller.loadingController.isLoading
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        AppliedLeaveDetailsTile(
                                          leaveType: "Sick Leave",
                                          applyDate: "10-01-2023",
                                          leaveFrom: "10-01-2023",
                                          leaveTo: "10-01-2023",
                                          status: "Approved",
                                          statusColor:
                                              AppColors.activeStatusRedColor,
                                          onTap: () {
                                            controller
                                                .showPendingListDetailsBottomSheet(
                                              index: index,
                                              reason: "Hudai",
                                              leaveType: "Sick Leave",
                                              applyDate: "10-01-2023",
                                              leaveFrom: "10-01-2023",
                                              leaveTo: "10-01-2023",
                                            );
                                          },
                                        ),
                                        20.verticalSpacing,
                                      ],
                                    );
                                  }),
                            ),
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
