// import 'package:flutter/material.dart';
// import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:intl/intl.dart';
//
// import 'app/data/constants/app_colors.dart';
// import 'app/data/constants/app_text_style.dart';
// import 'app/utilities/widgets/common_widgets/custom_background.dart';
// import 'app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
// import 'app/utilities/widgets/custom_dropdown.dart';
// import 'app/utilities/widgets/no_data_available/no_data_available_widget.dart';
// import 'app/utilities/widgets/show_week_tile/show_week_tile.dart';
// import 'app/utilities/widgets/student_class_details_card/student_calss_details_card.dart';
//
// class TestScreen extends StatelessWidget {
//
//
//   const TestScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: daysOfWeek.length,
//       child: InfixEduScaffold(
//         title: "Lesson Plan",
//         body: CustomBackground(
//           customWidget: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             child: Column(
//               children: [
//                  Row(
//                   children: [
//                     CustomDropdown(
//                       dropdownValue: recordDropdownValue.value,
//                       scheduleList: controller
//                           .homeController.studentRecordDropdownList,
//                       changeDropdownValue: (v) {
//                         controller.recordDropdownValue.value = v!;
//                         controller.examinationController.examDropdownList
//                             .clear();
//                         int recordId =
//                         controller.homeController.studentRecordIdList[
//                         controller.homeController
//                             .studentRecordDropdownList
//                             .indexOf(v)];
//                         controller.examinationController
//                             .getStudentExamList(recordId: recordId);
//                       },
//                     )
//                   ],
//                 ),
//                 Text(
//                   DateFormat("dd MMMM yyyy").format(DateTime.now()),
//                   style: AppTextStyle.fontSize14VioletW600,
//                 ),
//                 20.verticalSpacing,
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: AppColors.profileCardTextColor),
//                   ),
//                   child: TabBar(
//                     isScrollable: true,
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Colors.black,
//                     controller: tabController,
//                     indicator: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: AppColors.appButtonColor),
//                     tabs: List.generate(
//                       daysOfWeek.length,
//                           (index) => ShowWeekTile(
//                         title: daysOfWeek[index],
//                       ),
//                     ),
//                   ),
//                 ),
//                 10.verticalSpacing,
//                 Expanded(
//                   child: TabBarView(
//                     controller: tabController,
//                     children: List.generate(
//                       daysOfWeek.length,
//                           (index) {
//
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: 5,
//                           itemBuilder: (context, index) {
//                             return const StudentClassDetailsCard(
//                                 subject: "Bangla 1st Paper",
//                                 startingTime: "3:50 AM",
//                                 endingTime: "3:50 AM",
//                                 roomNumber: "103",
//                                 buildingName: 'Building Name',
//                                 instructorName: "Teacher Three"
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
