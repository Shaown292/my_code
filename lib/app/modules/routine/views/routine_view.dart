import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/show_week_tile/show_week_tile.dart';
import 'package:get/get.dart';
import '../../../../domain/core/model/student_routine_model/student_routine_response_model.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/student_class_details_card/student_calss_details_card.dart';
import '../controllers/routine_controller.dart';

class RoutineView extends GetView<RoutineController> {
  const RoutineView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.selectIndex.value,
      length: controller.daysOfWeek.length,
      child: Obx(
        () => InfixEduScaffold(
          title: controller.globalRxVariableController.roleId.value == 4
              ? "My Routine"
              : "Routine",
          leadingIcon: controller.globalRxVariableController.roleId.value == 4
              ? InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      ImagePath.back,
                      scale: 3,
                    ),
                  ),
                )
              : const SizedBox(),
          body: Obx(
            () => SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  CustomBackground(
                    customWidget: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                                      
                                        List<ClassRoutine> routineList = controller
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
                                                  return StudentClassDetailsCard(
                                                    subject:
                                                        routineList[index].subject,
                                                    startingTime:
                                                        routineList[index].startTime,
                                                    endingTime:
                                                        routineList[index].endTime,
                                                    roomNumber:
                                                        routineList[index].room,
                                                    buildingName: 'Building Name',
                                                    instructorName:
                                                        routineList[index].teacher,
                                                  );
                                                },
                                              );
                                      },
                                    ),
                                  ),
                                ),
                                200.verticalSpacing,
                              ],
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
