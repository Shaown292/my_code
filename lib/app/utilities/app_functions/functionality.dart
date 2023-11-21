import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../data/module_data/home_data/home_dummy_data.dart';
import '../../routes/app_pages.dart';

class AppFunctions {

  void getFunctions(int rule) {

    switch (rule) {
      case 1:
        GlobalVariable.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 2:
        GlobalVariable.homeTileList = studentList;
        Get.offAndToNamed(Routes.DASHBOARD, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 3:
        GlobalVariable.homeTileList = parentList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 4:
        GlobalVariable.homeTileList = teacherList;
        Get.offAndToNamed(Routes.DASHBOARD, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 5:
        GlobalVariable.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 9:
        GlobalVariable.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
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
        Get.toNamed(Routes.STUDENT_WALLET);
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
        Get.toNamed(Routes.LEAVE);
        break;
      case 'Dormitory':
        Get.toNamed(Routes.DORMITORY);
        break;
      case 'Transport':
        Get.toNamed(Routes.TRANSPORT);
        break;
      case 'Subjects':
        Get.toNamed(Routes.SUBJECTS);
        break;
      case 'Teacher':
        Get.toNamed(Routes.TEACHER);
        break;
      case 'Library':
        Get.toNamed(Routes.LIBRARY);
        break;
      case 'Notice':
        Get.toNamed(Routes.NOTICE);
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
        Get.toNamed(Routes.ATTENDANCE);
        break;
      case 'Settings':
        Get.toNamed(Routes.SETTINGS);
        break;
      case 'Lesson':
        Get.toNamed(Routes.STUDENT_LESSON_PLAN);
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
      case 'Apply Leave':
        Get.toNamed(Routes.APPLY_LEAVE);
        break;
      case 'Leave List':
        Get.toNamed(Routes.LEAVE_LIST);
        break;
      case 'Book List':
        Get.toNamed(Routes.BOOK_LIST);
        break;
      case 'Book Issued':
        Get.toNamed(Routes.BOOK_ISSUED);
        break;
      case 'Search Attendance':
        Get.toNamed(Routes.STUDENT_SEARCH_ATTENDANCE, arguments: {
        "from": false
        });
        break;
      case 'Search Sub Attendance':
        Get.toNamed(Routes.STUDENT_SEARCH_SUBJECT_ATTENDANCE);
        break;


    }
  }
  static void getAdminHomeNavigation({required String title}) {
    debugPrint(title);
    switch (title) {
      case 'Staff':
        Get.toNamed(Routes.STAFF);
        break;




    }
  }
}
