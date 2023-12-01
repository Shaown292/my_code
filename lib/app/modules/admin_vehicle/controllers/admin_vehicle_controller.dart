import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminVehicleController extends GetxController {

  TabController? tabController;

  TextEditingController vehicleNoTextController = TextEditingController();
  TextEditingController vehicleModelTextController = TextEditingController();
  TextEditingController madeYearTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  RxString initialValue = "Rohit Sharma".obs;
  RxList <String> list = [
    "Rohit Sharma",
    "Virat Kohli",
    "Subhman Gill"
  ].obs;

  List<String> tabs = <String>[
    'Add Vehicle',
    'Vehicle List',
  ];

}
