import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';

class AdminClassAttendanceIndividualDetailsController extends GetxController {

  final selectIndex = RxInt(0);
  DateTime currentDate = DateTime.now();
  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;

  RxInt present = 0.obs;
  RxInt halfDay = 0.obs;
  RxInt late = 0.obs;
  RxInt absent = 0.obs;
  RxInt holiday = 0.obs;

  /// Receive Arguments
  RxInt studentAttendanceId = 0.obs;


  @override
  void onInit() {
    studentAttendanceId.value = Get.arguments['student_attendance_id'];
    print(studentAttendanceId);
    super.onInit();
  }

}
