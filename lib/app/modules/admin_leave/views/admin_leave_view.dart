import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_leave/controllers/admin_leave_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/applied_leave_details_tile/applied_leave_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';

class AdminLeaveView extends GetView<AdminLeaveController> {
  const AdminLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.status.length,
      child: InfixEduScaffold(
        title: "Leave List",
        body: SingleChildScrollView(
          child: CustomBackground(
            customWidget: RefreshIndicator(
              onRefresh: () async {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TabBar(
                      labelColor: AppColors.profileValueColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle:
                      AppTextStyle.fontSize12LightGreyW500,
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
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  AppliedLeaveDetailsTile(
                                    leaveType: "Casual",
                                    applyDate: "12-03-2023",
                                    leaveFrom: "12-03-2023",
                                    leaveUntil: "12-03-2023",
                                    statusText: "Pending",
                                    statusColor: AppColors
                                        .activeStatusYellowColor,
                                    onTap: () {
                                      controller
                                          .showPendingListDetailsBottomSheet(
                                          index: index);
                                    },
                                  )
                                ],
                              );
                            })
                        ,

                        /// Approved

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  AppliedLeaveDetailsTile(
                                    leaveType: "Sick",
                                    applyDate: "12-03-2023",
                                    leaveFrom: "12-03-2023",
                                    leaveUntil: "12-03-2023",
                                    statusText: "Approved",
                                    statusColor: AppColors
                                        .activeStatusGreenColor,
                                    onTap: () {
                                      controller
                                          .showApprovedListDetailsBottomSheet(
                                          index: index);
                                    },
                                  )
                                ],
                              );
                            }),


                        /// Rejected

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  AppliedLeaveDetailsTile(
                                    leaveType: "Sick",
                                    applyDate: "12-03-2023",
                                    leaveFrom: "12-03-2023",
                                    leaveUntil: "12-03-2023",
                                    statusText: "Rejected",
                                    statusColor: AppColors
                                        .activeStatusRedColor,
                                    onTap: () {
                                      controller
                                          .showRejectedListDetailsBottomSheet(
                                          index: index);
                                    },
                                  )
                                ],
                              );
                            })

                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
