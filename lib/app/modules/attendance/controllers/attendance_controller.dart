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
    getAttendanceList(recordId: homeController.studentRecordList[0].id, studentId: GlobalVariableController.studentId!).then((value) => setEventData());
    // setEventData();
    super.onInit();
  }

  static const halfDayEvent = DisplayDot(color: Color(0xFF5057FC));
  static const presentEvent = DisplayDot(color: Color(0xFF00C106));
  static const lateEvent = DisplayDot(color: Color(0xFFFF6F00));
  static const absentEvent = DisplayDot(color: Color(0xFFF32E21));
  static const holidayEvent = DisplayDot(color: Color(0xFF462564));

  RxInt present = 0.obs;
  RxInt halfDay = 0.obs;
  RxInt late = 0.obs;
  RxInt absent = 0.obs;
  RxInt holiday = 0.obs;



  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;
  List<Attendances> attendanceList = [];

  void setEventData() {
    // customEventList[DateTime(2023, 11, 9)] = [Event(date: DateTime(2023, 11, 9), dot: presentEvent)];
    customEventList[DateTime(attendanceList[0].attendanceDate!.year, attendanceList[0].attendanceDate!.month, attendanceList[0].attendanceDate!.day)] = [Event(date: DateTime(attendanceList[0].attendanceDate!.year, attendanceList[0].attendanceDate!.month, attendanceList[0].attendanceDate!.day), dot: presentEvent)];

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
            customEventList[DateTime(attendanceList[i].attendanceDate!.year, attendanceList[i].attendanceDate!.month, attendanceList[i].attendanceDate!.day)] = [Event(date: DateTime(attendanceList[i].attendanceDate!.year, attendanceList[i].attendanceDate!.month, attendanceList[i].attendanceDate!.day), dot: presentEvent)];
            getAttendanceCount(attendanceList[i].attendanceType!);
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

  void getAttendanceCount(String status){
    switch (status) {
      case 'P':
        present++;
        break;
      case 'A':
        absent++;
        break;
      case 'L':
        late++;
        break;
      case 'F':
        halfDay++;
        break;
      case 'H':
        holiday++;
        break;

    }
  }

}

