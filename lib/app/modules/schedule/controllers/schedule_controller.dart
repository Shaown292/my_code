import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  //TODO: Implement ScheduleController

  List<String> dropdownList = [
    "Sun",
    "Mon",
    "Tues",
    "Wed",
    "Thu",
    "Fri",
  ];



  RxString dropdownValue = "Sun".obs;

  void getSchedule () {

    switch(dropdownValue){
      case 'Sun':
        const Text("Sunday is here");
        break;
      case 'Mon':
        const Text("Monday is here");
        break;
    }
  }

}
