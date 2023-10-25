import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutineController extends GetxController {
  PageController routinePageController = PageController();
  TabController? tabController;
  int selectedIndex = 0;
   List<String> days = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];



  RxInt pageIndex = 0.obs;
}
