import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_lesson_plan_details_response_model/students_lesson_plan_details_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_lesson_plan_response_model/student_lesson_plan_response_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class StudentLessonPlanController extends GetxController {
  HomeController homeController = Get.find();
  LoadingController loadingController = Get.find();
  TabController? tabController;
  StudentLessonPlanDetailsData? studentLessonPlanDetailsData;

  List<Weeks> weeksList = [];
  List<ClassRoutine> classRoutineList = [];


  final selectIndex = RxInt(0);
  RxInt selectTabIndex = 1.obs;



  String formattedDate = DateFormat("dd MMMM yyyy").format(DateTime.now());
  String today = DateFormat.E().format(DateTime.now());
  String formatDate = DateFormat("yyyy-MM-dd").format(DateTime.now());


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






  Future<StudentLessonPlanResponseModel?> getLessonPlanList(int userId, int recordId) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentLessonPlan(userId: userId, recordId: recordId),
        header: GlobalVariableController.header,
      );

     StudentLessonPlanResponseModel studentLessonPlanResponseModel = StudentLessonPlanResponseModel.fromJson(response);
      if (studentLessonPlanResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentLessonPlanResponseModel.data!.weeks!.isNotEmpty) {
          for (int i = 0;
          i < studentLessonPlanResponseModel.data!.weeks!.length;
          i++) {
            weeksList.add(studentLessonPlanResponseModel.data!.weeks![i]);

          }

        }


      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return StudentLessonPlanResponseModel();
  }


  Future<void> getLessonPlanListDetails(int lessonPlanId) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentLessonPlanDetails(lessonPlanId: lessonPlanId),
        header: GlobalVariableController.header,
      );

      StudentLessonPlanDetailsResponseModel studentLessonPlanDetailsResponseModel = StudentLessonPlanDetailsResponseModel.fromJson(response);

      if (studentLessonPlanDetailsResponseModel.success == true) {


        studentLessonPlanDetailsData = studentLessonPlanDetailsResponseModel.data;

      }
    } catch (e, t) {

      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

  }




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
                 BottomSheetTile(
                  title: "Class",
                  value: studentLessonPlanDetailsData?.classSection,
                  color: AppColors.homeworkWidgetColor,
                ),
                 BottomSheetTile(
                  title: "Subject Name",
                  value: studentLessonPlanDetailsData?.subject,
                ),
                 BottomSheetTile(
                  title: "Date",
                  value: studentLessonPlanDetailsData?.date,
                  color: AppColors.homeworkWidgetColor,
                ),
                 BottomSheetTile(
                  title: "Lesson",
                  value: studentLessonPlanDetailsData?.lesson,
                ),
                 BottomSheetTile(
                  title: "Topic",
                  hasMultipleData: true,
                  listview: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: studentLessonPlanDetailsData?.topic?.length ,
                      itemBuilder: (context, index) {
                        debugPrint("Topic ::::::: ${studentLessonPlanDetailsData?.topic?.length}");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "0${index + 1}. ${studentLessonPlanDetailsData?.topic![index].topicTitle}",
                            style: AppTextStyle.blackFontSize12W400,
                            textAlign: TextAlign.justify,
                          ),
                        );
                      }),
                  color: AppColors.homeworkWidgetColor,
                ),

                BottomSheetTile(
                  title: "Sub Topic",
                  hasMultipleData: true,
                  listview: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: studentLessonPlanDetailsData?.subtopic?.length ,
                      itemBuilder: (context, index) {
                        debugPrint("Topic ::::::: ${studentLessonPlanDetailsData?.subtopic?.length}");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "0${index + 1}. ${studentLessonPlanDetailsData?.subtopic![index].subTopicTitle}",
                            style: AppTextStyle.blackFontSize12W400,
                            textAlign: TextAlign.justify,
                          ),
                        );
                      }),
                ),
                 BottomSheetTile(
                  title: "Note",
                  value: studentLessonPlanDetailsData?.note,
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
                BottomSheetTile(
                  title: "Youtube Link",
                  value: studentLessonPlanDetailsData?.lectureYoutubeLink,
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
                          value: studentLessonPlanDetailsData?.status ?? false,
                          onChanged: (bool value) {
                            value = studentLessonPlanDetailsData?.status ?? false;
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




  void selectTab() {
    selectTabIndex.value = daysOfWeek.indexOf(today);
  }

  @override
  void onInit() async {
    await getLessonPlanList(GlobalVariableController.userId!, homeController.studentRecordList[0].id);

    debugPrint("Week::::: ${weeksList.length}");
    int weekIndex = weeksList.indexWhere((week) => week.date == formatDate);

    debugPrint("Today::::: $weekIndex date:::: $formatDate");

    if(weekIndex != -1 ){
      await getLessonPlanListDetails(weeksList[weekIndex].id!);

    }
    selectTab();
    super.onInit();
  }
}
