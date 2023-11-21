import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_search_attendance/views/widget/display_dot.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/attendance_response_model/student_attendance_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';
import '../../home/controllers/home_controller.dart';

class StudentSearchAttendanceController extends GetxController {
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

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
  RxInt recordId = 0.obs;
  RxBool fromStatus = false.obs;

  DateTime currentDate = DateTime.now();
  final selectIndex = RxInt(0);

  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;
  List<Attendances> attendanceList = [];

  int? subjectId;

  void setEventData() {
    // customEventList[DateTime(2023, 11, 9)] = [Event(date: DateTime(2023, 11, 9), dot: presentEvent)];
    customEventList[DateTime(
        attendanceList[0].attendanceDate!.year,
        attendanceList[0].attendanceDate!.month,
        attendanceList[0].attendanceDate!.day)] = [
      Event(
          date: DateTime(
              attendanceList[0].attendanceDate!.year,
              attendanceList[0].attendanceDate!.month,
              attendanceList[0].attendanceDate!.day),
          dot: presentEvent)
    ];

    eventList = EventList<Event>(events: customEventList);

    update();
  }

  Future<StudentAttendanceResponseModel?> getAttendanceList({
    required int recordId,
    required int studentId,
  }) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentAttendance(
            recordId: recordId, studentId: studentId),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                  date: DateTime(
                      attendanceList[i].attendanceDate!.year,
                      attendanceList[i].attendanceDate!.month,
                      attendanceList[i].attendanceDate!.day),
                  dot: presentEvent)
            ];
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

  Future<StudentAttendanceResponseModel?> getAttendanceListWithDate({
    required int recordId,
    required int studentId,
    required int year,
    required int month,
  }) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentAttendanceWithDate(
          recordId: recordId,
          studentId: studentId,
          year: year,
          month: month,
        ),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                  date: DateTime(
                      attendanceList[i].attendanceDate!.year,
                      attendanceList[i].attendanceDate!.month,
                      attendanceList[i].attendanceDate!.day),
                  dot: presentEvent)
            ];
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

  Future<StudentAttendanceResponseModel?> getSearchSubjectAttendanceList({
    required int recordId,
    required int studentId,
    required int subjectId,
  }) async {
    try {
      // LoadingController loadingController = Get.put(LoadingController());

      // loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentSubjectSearchAttendance(
            recordId: recordId, studentId: studentId, subjectId: subjectId),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                  date: DateTime(
                      attendanceList[i].attendanceDate!.year,
                      attendanceList[i].attendanceDate!.month,
                      attendanceList[i].attendanceDate!.day),
                  dot: presentEvent)
            ];
          }
        }
      } else {
        showBasicFailedSnackBar(
            message: attendanceResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      //loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
      t.printInfo();
    } finally {
      loadingController.isLoading = false;
    }
    return StudentAttendanceResponseModel();
  }

  Future<StudentAttendanceResponseModel?>
      getSearchSubjectAttendanceListWithDate({
    required int recordId,
    required int studentId,
    required int subjectId,
    required int year,
    required int month,
  }) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentSubjectSearchAttendanceWithDate(
          recordId: recordId,
          studentId: studentId,
          year: year,
          month: month,
          subjectId: subjectId,
        ),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                  date: DateTime(
                      attendanceList[i].attendanceDate!.year,
                      attendanceList[i].attendanceDate!.month,
                      attendanceList[i].attendanceDate!.day),
                  dot: presentEvent)
            ];
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

  @override
  void onInit() {
    fromStatus.value = Get.arguments["from"];
    if (homeController.studentRecordList.isNotEmpty) {
      recordId.value = homeController.studentRecordList[0].id;
    }

    if (fromStatus.value) {
      subjectId = Get.arguments["subjectID"];

      getSearchSubjectAttendanceList(
              recordId: recordId.toInt(),
              studentId: GlobalVariable.studentId!,
              subjectId: subjectId!)
          .then((value) => setEventData());
    } else {
      getAttendanceList(
              recordId: recordId.toInt(),
              studentId: GlobalVariable.studentId!)
          .then((value) => setEventData());
    }

    super.onInit();
  }
}
