import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/attendance_response_model/student_attendance_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../views/widget/display_dot.dart';

class AttendanceController extends GetxController {

  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  @override
  void onInit() {
    setEventData();
    super.onInit();
  }

  static const halfDayEvent = DisplayDot(color: Color(0xFF5057FC));
  static const presentEvent = DisplayDot(color: Color(0xFF00C106));
  static const lateEvent = DisplayDot(color: Color(0xFFFF6F00));
  static const absentEvent = DisplayDot(color: Color(0xFFF32E21));
  static const holidayEvent = DisplayDot(color: Color(0xFF462564));



  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;
  List<Attendances> attendanceList = [];

  void setEventData() {

    customEventList[DateTime(2023, 10, 26)] = [Event(date: DateTime(2023, 10, 26), dot: presentEvent)];
    customEventList = {

      DateTime(2023, 10, 26): [Event(date: DateTime(2023, 10, 26), dot: presentEvent)],
      DateTime(2023, 10, 27): [Event(date: DateTime(2023, 10, 27), dot: lateEvent)],
      DateTime(2023, 10, 2): [Event(date: DateTime(2023, 10, 2), dot: holidayEvent)],
      DateTime(2023, 10, 28): [Event(date: DateTime(2023, 10, 28), dot: halfDayEvent)],

      DateTime(2023, 11, 26): [Event(date: DateTime(2023, 11, 26), dot: presentEvent)],
      DateTime(2023, 11, 27): [Event(date: DateTime(2023, 11, 27), dot: lateEvent)],
      DateTime(2023, 11, 2): [Event(date: DateTime(2023, 11, 2), dot: holidayEvent)],
      DateTime(2023, 11, 28): [Event(date: DateTime(2023, 11, 28), dot: halfDayEvent)],

    };

    eventList = EventList<Event>(events: customEventList);

    update();
  }


  Future<StudentAttendanceResponseModel?> getAttendanceList({required int recordId, required int studentId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentAttendance(recordId: recordId, studentId: studentId),
        header: GlobalVariableController.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
      StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
          i < attendanceResponseModel.data!.attendances!.length; i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
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
    return StudentAttendanceResponseModel();
  }


}

