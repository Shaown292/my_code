import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get.dart';

import '../views/widget/display_dot.dart';

class AttendanceController extends GetxController {
  //TODO: Implement AttendanceController

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

  void setEventData() {



    customEventList[DateTime(2023, 10, 26)] = [Event(date: DateTime(2023, 10, 26), dot: presentEvent)];
    customEventList = {

      DateTime(2023, 10, 26): [Event(date: DateTime(2023, 10, 26), dot: presentEvent)],
      DateTime(2023, 10, 27): [Event(date: DateTime(2023, 10, 27), dot: lateEvent)],
      DateTime(2023, 10, 2): [Event(date: DateTime(2023, 10, 2), dot: holidayEvent)],
      DateTime(2023, 10, 28): [Event(date: DateTime(2023, 10, 28), dot: halfDayEvent)]

    };

    eventList = EventList<Event>(events: customEventList);

    update();
  }
}
