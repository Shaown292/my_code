import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRouteController extends GetxController {

  TabController? tabController;

  TextEditingController routeTitleTextController = TextEditingController();
  TextEditingController routeFareTextController = TextEditingController();

  List<String> tabs = <String>[
    'Route List',
    'Add New',
  ];
}
