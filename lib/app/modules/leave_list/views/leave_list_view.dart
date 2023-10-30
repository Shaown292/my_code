import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/leave_list/views/widget/leave_details.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/leave_list_controller.dart';

class LeaveListView extends GetView<LeaveListController> {
  const LeaveListView({Key? key}) : super(key: key);
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
              Card(
                margin: EdgeInsets.zero,
                elevation: 8,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Leave",
                        style: AppTextStyle.fontSize12LightViolateW500,
                      ),
                    ],
                  ),
                ),
              ),
              30.verticalSpacing,
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Leave List",
                  style: AppTextStyle.fontSize12LightViolateW500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TabBar(
                  labelColor: AppColors.profileValueColor,
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
                  children:  [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context , index){
                          return  const Column(
                            children: [
                             LeaveDetails(
                               title: "Sick Leave",
                               applyDate: "2023-10-21",
                               leaveFrom: "2023-10-22",
                               leaveUntil: "2023-10-25",
                               statusText: "pending",
                             )

                            ],
                          );
                        }
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
