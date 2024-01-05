import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_lesson_plan_details_response_model/students_lesson_plan_details_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_lesson_plan_response_model/student_lesson_plan_response_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class StudentLessonPlanController extends GetxController {
  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();
  HomeController homeController = Get.find();
  TabController? tabController;

  List<Weeks> weeksList = [];
  List<ClassRoutine> classRoutineList = [];

  final selectIndex = RxInt(0);
  RxInt selectTabIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool lessonLoader = false.obs;

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

  Future<StudentLessonPlanResponseModel?> getLessonPlanList({
    required int studentId,
    required int recordId,
    required String date,
  }) async {
    try {
      lessonLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentLessonPlan(
            studentId: studentId, recordId: recordId, date: date),
        header: GlobalVariable.header,
      );

      StudentLessonPlanResponseModel studentLessonPlanResponseModel =
          StudentLessonPlanResponseModel.fromJson(response);
      if (studentLessonPlanResponseModel.success == true) {
        lessonLoader.value = false;
        if (studentLessonPlanResponseModel.data!.weeks!.isNotEmpty) {
          for (int i = 0;
              i < studentLessonPlanResponseModel.data!.weeks!.length;
              i++) {
            weeksList.add(studentLessonPlanResponseModel.data!.weeks![i]);
          }
        }
      } else {
        showBasicFailedSnackBar(
            message: studentLessonPlanResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      lessonLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      lessonLoader.value = false;
    }
    return StudentLessonPlanResponseModel();
  }

  Future<void> getLessonPlanListDetails(
      {required int lessonPlanId, required BuildContext context}) async {
    try {
      ///Show Loader Dialog

      AlertDialog alert = AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconColor: Colors.transparent,
        content: Center(child: Lottie.asset('assets/images/loader.json')),
      );

      showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: AppColors.secondaryColor.withOpacity(0.15),
        builder: (BuildContext context) {
          return alert;
        },
      );

      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getStudentLessonPlanDetails(lessonPlanId: lessonPlanId),
        header: GlobalVariable.header,
      );

      StudentLessonPlanDetailsResponseModel
          studentLessonPlanDetailsResponseModel =
          StudentLessonPlanDetailsResponseModel.fromJson(response);

      if (studentLessonPlanDetailsResponseModel.success == true) {
        Get.back();

        // studentLessonPlanDetailsData = studentLessonPlanDetailsResponseModel.data;
        if (studentLessonPlanDetailsResponseModel.data == null) {
          showBasicFailedSnackBar(message: 'No Details Available');
        } else {
          showLessonPlanDetailsBottomSheet(
              studentLessonPlanDetailsData:
                  studentLessonPlanDetailsResponseModel.data!,
              backgroundColor: Colors.white);
        }
      } else {
        showBasicFailedSnackBar(
            message: studentLessonPlanDetailsResponseModel.message ??
                'Something went wrong.');
        Get.back();
      }
    } catch (e, t) {
      Get.back();
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
      debugPrint("Details ::::::: $isLoading");
    }
  }

  void showLessonPlanDetailsBottomSheet(
      {required StudentLessonPlanDetailsData studentLessonPlanDetailsData,
      Color? backgroundColor}) {
    Get.bottomSheet(
      Container(
          color: backgroundColor,
          height: Get.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpacing,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    studentLessonPlanDetailsData.classSection ?? "",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                ),
                BottomSheetTile(
                  title: "Subject Name",
                  value: studentLessonPlanDetailsData.subject,
                ),
                BottomSheetTile(
                  title: "Date",
                  value: studentLessonPlanDetailsData.date,
                  color: AppColors.homeworkWidgetColor,
                ),
                BottomSheetTile(
                  title: "Lesson",
                  value: studentLessonPlanDetailsData.lesson,
                ),
                BottomSheetTile(
                  title: "Topic",
                  hasMultipleData: true,
                  listview: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: studentLessonPlanDetailsData.topic?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "0${index + 1}. ${studentLessonPlanDetailsData.topic![index]}",
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
                      itemCount: studentLessonPlanDetailsData.subtopic?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${index + 1}. ${studentLessonPlanDetailsData.subtopic![index]}",
                            style: AppTextStyle.blackFontSize12W400,
                            textAlign: TextAlign.justify,
                          ),
                        );
                      }),
                ),
                BottomSheetTile(
                  title: "Note",
                  value: studentLessonPlanDetailsData.note,
                  color: AppColors.homeworkWidgetColor,
                ),
                Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.homeworkWidgetColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: Get.width * 0.41,
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
                          onTap: () {

                          },
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
                  value: studentLessonPlanDetailsData.lectureYoutubeLink,
                  color: AppColors.homeworkWidgetColor,
                ),
                Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.homeworkWidgetColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: Get.width * 0.41,
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
                          value: studentLessonPlanDetailsData.status ?? false,
                          onChanged: (bool value) {
                            value =
                                studentLessonPlanDetailsData.status ?? false;
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
  void onInit() {

    selectTab();
    if (homeController.studentRecordList.isNotEmpty &&
        globalRxVariableController.studentId.value != null) {
      getLessonPlanList(
        studentId: globalRxVariableController.studentId.value!,
        recordId: globalRxVariableController.studentRecordId.value!,
        date: DateTime.now().yyyy_mm_dd,
      );
    }
    super.onInit();
  }
}
