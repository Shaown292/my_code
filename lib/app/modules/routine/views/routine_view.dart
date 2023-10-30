import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/routine_card.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/week_tab_bar_item.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../../domain/core/model/student_routine_model/StudentRoutineResponseModel.dart';
import '../../../data/constants/app_colors.dart';
import '../controllers/routine_controller.dart';

class RoutineView extends GetView<RoutineController> {
  const RoutineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.daysOfWeek.length,
      child: Obx(
        () => InfixEduScaffold(
          title: "Routine",
          leadingIcon: const SizedBox(),
          body: CustomBackground(
            customWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: controller.loadingController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : Column(
                      children: [
                        const Text(
                          "24th February 2021",
                          style: AppTextStyle.fontSize14VioletW600,
                        ),
                        20.verticalSpacing,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.profileCardTextColor)),
                          child: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            controller: controller.tabController,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.appButtonColor),
                            tabs: List.generate(
                              controller.daysOfWeek.length,
                              (index) => WeekTabBarItem(
                                title: controller.daysOfWeek[index],
                              ),
                            ),
                          ),
                        ),
                        10.verticalSpacing,
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              controller.daysOfWeek.length,
                              (index) {
                                List<ClassRoutine>? routineList = controller
                                    .classRoutineList
                                    .where((element) =>
                                        element.day?.substring(0, 3) ==
                                        controller.daysOfWeek[index])
                                    .toList();

                                return routineList.isEmpty
                                    ? const NoDataAvailableWidget()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: routineList.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              RoutineCard(
                                                subject:
                                                    routineList[index].subject,
                                                startingTime: routineList[index]
                                                    .startTime,
                                                endingTime:
                                                    routineList[index].endTime,
                                                roomNumber:
                                                    routineList[index].room,
                                                buildingName: 'Building Name',
                                                instructorName:
                                                    routineList[index].teacher,
                                              ),
                                            ],
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
