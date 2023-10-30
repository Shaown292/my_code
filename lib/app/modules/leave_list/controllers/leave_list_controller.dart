import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveListController extends GetxController {

  TabController? tabController;
  int selectedIndex = 0;
  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];
}
