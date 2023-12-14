import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_search_attendance/views/widget/display_dot.dart';
import 'package:get/get.dart';

import '../../app/data/module_data/home_data/home_dummy_data.dart';

class GlobalVariable {


  static List<HomeTileModelClass> homeTileList = [];
  // static int? roleId;
  // static String? token;
  // static int notificationCount = 0;
  // static int? studentRecordId;
  // static int? studentId;
  // static int? userId;
  static const halfDayEvent = DisplayDot(color: Color(0xFF5057FC));
  static const presentEvent = DisplayDot(color: Color(0xFF00C106));
  static const lateEvent = DisplayDot(color: Color(0xFFFF6F00));
  static const absentEvent = DisplayDot(color: Color(0xFFF32E21));
  static const holidayEvent = DisplayDot(color: Color(0xFF462564));

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':  Get.find<GlobalRxVariableController>().token.value!,
  };

  static getAttendanceStatus(String attendanceStatus) {

    if (attendanceStatus == "P"){
     return presentEvent;
    }
    else if (attendanceStatus == "A"){
     return absentEvent;
    }
    else if (attendanceStatus == "F"){
     return halfDayEvent;
    }
    else if (attendanceStatus == "L"){
     return lateEvent;
    }
    else if (attendanceStatus == "H"){
     return holidayEvent;
    }
  }
}

class GlobalRxVariableController extends GetxController {

  // RxInt notificationCount = 0.obs;
  // RxInt? studentRecordId;
  // RxInt roleId = 0.obs;
  // RxString token = ''.obs;
  // RxInt studentId = 0.obs;
  // RxInt? userId;

  final notificationCount = Rxn<int>();
  final studentRecordId = Rxn<int>();
  final roleId = Rxn<int>();
  final token = Rxn<String>();
  final studentId = Rxn<int>();
  final userId = Rxn<int>();

}

