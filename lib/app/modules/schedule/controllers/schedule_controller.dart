import 'package:get/get.dart';

class ScheduleController extends GetxController {
  //TODO: Implement ScheduleController

  List<String> dropdownList = [
    "Sun",
    "Mon",
    "Wed",
  ];

  RxString dropdownValue = "Sun".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
