//
// import 'package:flutter/material.dart';
// import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
// import 'package:flutter_single_getx_api_v2/app/modules/routine/controllers/routine_controller.dart';
// import 'package:flutter_single_getx_api_v2/app/modules/routine/views/widget/week_tab_bar_item.dart';
// import 'package:get/get.dart';
//
// class WeekTabBarView extends StatelessWidget {
//
//   final RoutineController controller;
//
//   const WeekTabBarView({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.profileCardTextColor)
//       ),
//       child: Obx(()=> Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           WeekTabBarItem(
//             title: "Mon",
//             isActive: controller.pageIndex.value == 0 ? true : false,
//             // onTap: () {
//             //   print(controller.pageIndex.value == 0 ? true : false);
//             //   controller.pageIndex.value = 0;
//             //   controller.routinePageController.jumpToPage(0);
//             // },
//           ),
//           WeekTabBarItem(
//             title: "Tue",
//             isActive: controller.pageIndex.value == 1 ? true : false,
//             // onTap: () {
//             //   print(controller.pageIndex.value == 1 ? true : false);
//             //   controller.pageIndex.value = 1;
//             //   controller.routinePageController.jumpToPage(1);
//             // },
//           ),
//
//           WeekTabBarItem(
//             title: "Wed",
//             isActive: controller.pageIndex.value == 2 ? true : false,
//             // onTap: () {
//             //   print(controller.pageIndex.value == 2 ? true : false);
//             //   controller.pageIndex.value = 2;
//             //   controller.routinePageController.jumpToPage(2);
//             // },
//           ),
//
//           WeekTabBarItem(
//             title: "Thu",
//             isActive: controller.pageIndex.value == 3 ? true : false,
//             // onTap: () {
//             //   print(controller.pageIndex.value == 3 ? true : false);
//             //   controller.pageIndex.value = 3;
//             //   controller.routinePageController.jumpToPage(3);
//             // },
//           ),
//
//           WeekTabBarItem(
//             title: "Fri",
//             isActive: controller.pageIndex.value == 4 ? true : false,
//             // onTap: () {
//             //   print(controller.pageIndex.value == 4 ? true : false);
//             //   controller.pageIndex.value = 4;
//             //   controller.routinePageController.jumpToPage(4);
//             // },
//           ),
//
//           WeekTabBarItem(
//             title: "Sat",
//             isActive: controller.pageIndex.value == 5 ? true : false,
//             // onTap: () {
//             //   print(controller.pageIndex.value == 5 ? true : false);
//             //   controller.pageIndex.value = 5;
//             //   controller.routinePageController.jumpToPage(5);
//             // },
//           ),
//
//
//         ],
//       )),
//     );
//   }
// }
