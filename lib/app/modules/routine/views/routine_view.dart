import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/leave_card.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/routine_card.dart';
import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/week_tab_bar_view.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/routine_controller.dart';

class RoutineView extends GetView<RoutineController> {

  const RoutineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Routine",
      body: CustomBackground(
          customWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            20.verticalSpacing,
            WeekTabBarView(
              controller: controller,
            ),
            10.verticalSpacing,
            Expanded(
              child: PageView(
                controller: controller.routinePageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Column(
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
                        subject: "Computer Science",
                        startingTime: "8:15 am",
                        endingTime: "9:00 am",
                        roomNumber: "201",
                        buildingName: "East Building",
                        instructorName: "James Anderson",
                      ),
                      LeaveCard(
                        startingTime: "2:00 pm",
                        endingTime: "2:30 pm",
                      ),
                    ],
                  ),
                  Column(
                    children: [

                      RoutineCard(
                        subject: "Computer Science",
                        startingTime: "8:15 am",
                        endingTime: "9:00 am",
                        roomNumber: "201",
                        buildingName: "East Building",
                        instructorName: "James Anderson",
                      ),
                      LeaveCard(
                        startingTime: "2:00 pm",
                        endingTime: "2:30 pm",
                      ),
                    ],
                  ),
                  Column(
                    children: [

                      RoutineCard(
                        subject: "Computer Science",
                        startingTime: "8:15 am",
                        endingTime: "9:00 am",
                        roomNumber: "201",
                        buildingName: "East Building",
                        instructorName: "James Anderson",
                      ),
                      LeaveCard(
                        startingTime: "2:00 pm",
                        endingTime: "2:30 pm",
                      ),
                    ],
                  ),

                ],
              ),
            ),



          ],
        ),
      )),
    );
  }
}
