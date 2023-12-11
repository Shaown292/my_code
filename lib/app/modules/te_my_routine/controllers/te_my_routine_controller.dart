import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeMyRoutineController extends GetxController {
  TabController? tabController;

  LoadingController loadingController = Get.find();
  RxInt selectIndex = 1.obs;



  List<String> daysOfWeek = <String>[
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

  String formattedDate = DateFormat("dd MMMM yyyy").format(DateTime.now());
  String today = DateFormat.E().format(DateTime.now());
  void selectTab() {
    selectIndex.value = daysOfWeek.indexOf(today);
  }
}
