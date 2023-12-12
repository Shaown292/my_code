import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/show_week_tile/show_week_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/student_class_details_card/student_calss_details_card.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';

import 'package:get/get.dart';

import '../controllers/te_my_routine_controller.dart';

class TeMyRoutineView extends GetView<TeMyRoutineController> {
  const TeMyRoutineView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.selectIndex.value,
      length: controller.daysOfWeek.length,
      child: InfixEduScaffold(
        title: "My Routine",
        body: Obx(
              () => CustomBackground(
            customWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: controller.loadingController.isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
                  : Column(
                children: [
                  Text(
                    controller.formattedDate,
                    style: AppTextStyle.fontSize14VioletW600,
                  ),
                  20.verticalSpacing,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.profileCardTextColor),
                    ),
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerHeight: 0,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      controller: controller.tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.appButtonColor),
                      tabs: List.generate(
                        controller.daysOfWeek.length,
                            (index) => ShowWeekTile(
                          title: controller.daysOfWeek[index],
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpacing,
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: List.generate(
                        controller.daysOfWeek.length,
                            (index) {

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.daysOfWeek.length,
                            itemBuilder: (context, index) {
                              return const StudentClassDetailsCard(
                                startingTime: "9:30",
                                subject:"Bangla",
                                endingTime:"10:30 AM",
                                roomNumber:"130",
                                buildingName: 'Building Name',
                                instructorName: "Murad Takla",
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
