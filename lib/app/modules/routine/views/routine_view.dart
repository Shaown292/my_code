import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/routine_card.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/week_tab_bar_item.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../controllers/routine_controller.dart';

class RoutineView extends GetView<RoutineController> {
  const RoutineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.days.length,
      child: InfixEduScaffold(
        title: "Routine",
        leadingIcon: const SizedBox(),
        body: CustomBackground(
            customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              const Text(
                  "24th February 2021",
                style: AppTextStyle.fontSize14VioletW600,
              ),
              20.verticalSpacing,
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.profileCardTextColor)),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  controller: controller.tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appButtonColor),
                  tabs: List.generate(
                    controller.days.length,
                    (index) => WeekTabBarItem(
                      title: controller.days[index],
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
                       return const Column(
                         children: [
                           RoutineCard(
                             subject: "Computer Science",
                             startingTime: "8:15 am",
                             endingTime: "9:00 am",
                             roomNumber: "201",
                             buildingName: "East Building",
                             instructorName: "James Anderson",
                           ),
                           RoutineCard(
                             subject: "Lunch Break",
                             startingTime: "8:15 am",
                             endingTime: "9:00 am",
                             isLunchBreak: true,
                           ),
                         ],
                       );

                       }
                   ),
                    ListView.builder(
                     itemCount: 2,
                       itemBuilder: (context , index){

                       return const Column(
                         children: [
                           RoutineCard(
                             subject: "Computer Science",
                             startingTime: "8:15 am",
                             endingTime: "9:00 am",
                             roomNumber: "201",
                             buildingName: "East Building",
                             instructorName: "James Anderson",
                           ),
                           RoutineCard(
                             subject: "Lunch Break",
                             startingTime: "8:15 am",
                             endingTime: "9:00 am",
                             isLunchBreak: true,
                           ),
                           RoutineCard(
                             subject: "Computer Science",
                             startingTime: "8:15 am",
                             endingTime: "9:00 am",
                             roomNumber: "201",
                             buildingName: "East Building",
                             instructorName: "James Anderson",
                           ),
                         ],
                       );

                       }
                   ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context , index){
                          return const Column(
                            children: [
                              RoutineCard(
                                subject: "Computer Science",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                roomNumber: "201",
                                buildingName: "East Building",
                                instructorName: "James Anderson",
                              ),
                              RoutineCard(
                                subject: "Lunch Break",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                isLunchBreak: true,
                              ),
                            ],
                          );

                        }
                    ),
                    ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context , index){

                          return const Column(
                            children: [
                              RoutineCard(
                                subject: "Computer Science",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                roomNumber: "201",
                                buildingName: "East Building",
                                instructorName: "James Anderson",
                              ),
                              RoutineCard(
                                subject: "Lunch Break",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                isLunchBreak: true,
                              ),
                              RoutineCard(
                                subject: "Computer Science",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                roomNumber: "201",
                                buildingName: "East Building",
                                instructorName: "James Anderson",
                              ),
                            ],
                          );

                        }
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context , index){
                          return const Column(
                            children: [
                              RoutineCard(
                                subject: "Computer Science",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                roomNumber: "201",
                                buildingName: "East Building",
                                instructorName: "James Anderson",
                              ),
                              RoutineCard(
                                subject: "Lunch Break",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                isLunchBreak: true,
                              ),
                            ],
                          );

                        }
                    ),
                    ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context , index){

                          return const Column(
                            children: [
                              RoutineCard(
                                subject: "Computer Science",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                roomNumber: "201",
                                buildingName: "East Building",
                                instructorName: "James Anderson",
                              ),
                              RoutineCard(
                                subject: "Lunch Break",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                isLunchBreak: true,
                              ),
                              RoutineCard(
                                subject: "Computer Science",
                                startingTime: "8:15 am",
                                endingTime: "9:00 am",
                                roomNumber: "201",
                                buildingName: "East Building",
                                instructorName: "James Anderson",
                              ),
                            ],
                          );

                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
