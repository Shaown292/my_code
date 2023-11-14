import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class StudentLessonPlanController extends GetxController {
  HomeController homeController = Get.find();

  final selectIndex = RxInt(0);
  bool status = true;
  List<String> daysOfWeek = <String>[
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];
  TabController? tabController;

  RxString recordDropdownValue = "Sat".obs;

  String formattedDate = DateFormat("dd MMMM yyyy").format(DateTime.now());
  String today = DateFormat.E().format(DateTime.now());

  void showLessonPlanDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      SizedBox(
          height: Get.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpacing,
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Saturday",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                ),
                const BottomSheetTile(
                  title: "Class",
                  value: "One (A)",
                  color: AppColors.homeworkWidgetColor,
                ),
                const BottomSheetTile(
                  title: "Subject Name",
                  value: "bangla 1st",
                ),
                const BottomSheetTile(
                  title: "Date",
                  value: "13-03-2023",
                  color: AppColors.homeworkWidgetColor,
                ),
                const BottomSheetTile(
                  title: "Lesson",
                  value: "Data Structure",
                ),
                const BottomSheetTile(
                  title: "Topic",
                  value: "Topic One",
                  color: AppColors.homeworkWidgetColor,
                ),
                const BottomSheetTile(
                  title: "Sub Topic",
                  value: "Sub Topic One",
                ),
                const BottomSheetTile(
                  title: "Note",
                  value: "Topic One",
                  color: AppColors.homeworkWidgetColor,
                ),

                Container(
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.homeworkWidgetColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: Get.width * 0.3,
                        child: const Text(
                          "Documents",
                          style: AppTextStyle.fontSize12lightViolateW400,
                        ),
                      ),
                      VerticalDivider(
                        color: AppColors.bottomSheetDividerColor,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.download,
                                size: 15,
                                color: Color(0xFF3490DC),
                              ),
                              5.horizontalSpacing,
                              const Text(
                                "Download",
                                style: TextStyle(
                                  color: Color(0xFF3490DC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const BottomSheetTile(
                  title: "Note",
                  value: "Note",
                  color: AppColors.homeworkWidgetColor,
                ),

                Container(
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.homeworkWidgetColor,
                    ),

                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: Get.width * 0.3,
                        child: const Text(
                          "Status",
                          style: AppTextStyle.fontSize12lightViolateW400,
                        ),
                      ),
                      VerticalDivider(
                        color: AppColors.bottomSheetDividerColor,
                        thickness: 1,
                      ),
                      Switch(
                          value: status,
                          onChanged: (bool value) {
                            value = status;
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }
}
