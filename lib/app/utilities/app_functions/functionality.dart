import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../data/module_data/home_data/home_dummy_data.dart';
import '../../routes/app_pages.dart';

class AppFunctions {
  void getFunctions(int rule) {
    Route route;

    switch (rule) {
      case 1:
        GlobalVariableController.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariableController.homeTileList,
        });
        break;
      case 2:
        GlobalVariableController.homeTileList = studentList;
        Get.offAndToNamed(Routes.DASHBOARD, arguments: {
          'homeListTile': GlobalVariableController.homeTileList,
        });
        break;
      case 3:
        GlobalVariableController.homeTileList = parentList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariableController.homeTileList,
        });
        break;
      case 4:
        GlobalVariableController.homeTileList = teacherList;
        Get.offAndToNamed(Routes.DASHBOARD, arguments: {
          'homeListTile': GlobalVariableController.homeTileList,
        });
        break;
      case 5:
        GlobalVariableController.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariableController.homeTileList,
        });
        break;
      case 9:
        GlobalVariableController.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariableController.homeTileList,
        });
        break;
    }
  }

  /// Student List Tile Navigation
  static void getStudentDashboardNavigation({required String title}) {
    debugPrint(title);
    switch (title) {
      case 'Profile':
        break;
      case 'Wallet':
        break;
      case 'Routine':
        break;
      case 'Homework':
        Get.toNamed(Routes.STUDENT_HOMEWORK);
        break;
      case 'Study Materials':
        Get.toNamed(Routes.STUDY_MATERIALS);
        break;
      case 'Leave':
        break;
      case 'Dormitory':
        break;
      case 'Transport':
        break;
      case 'Subjects':
        break;
      case 'Teacher':
        break;
      case 'Library':
        break;
      case 'Notice':
        break;
      case 'Timeline':
        break;
      case 'Examination':
        Get.toNamed(Routes.EXAMINATION);
        break;
      case 'Online Exam':
        Get.toNamed(Routes.ONLINE_EXAM);
        break;
      case 'Attendance':
        break;
      case 'Settings':
        Get.toNamed(Routes.SETTINGS);
        break;
      case 'Lesson':
        break;
      case 'Class':
        break;
      case 'Assignment':
        Get.toNamed(Routes.ASSIGNMENT);
        break;
      case 'Syllabus':
        Get.toNamed(Routes.SYLLABUS);
        break;
      case 'Schedule':
        Get.toNamed(Routes.SCHEDULE);
        break;
      case 'Result':
        Get.toNamed(Routes.RESULT);
        break;
      case 'Active Exam':
        Get.toNamed(Routes.ACTIVE_EXAM);
        break;
      case 'Exam Result':
        Get.toNamed(Routes.EXAM_RESULT);
        break;
      case 'Other Downloads':
        Get.toNamed(Routes.OTHER_DOWNLOADS);
        break;

    }
  }
}
