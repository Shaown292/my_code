import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

class AdminAddDormitoryController extends GetxController {

  TextEditingController dormitoryNameController = TextEditingController();
  TextEditingController dormitoryIntake = TextEditingController();
  TextEditingController dormitoryAddress = TextEditingController();
  TextEditingController dormitoryNote = TextEditingController();


  RxString dropdownValue = 'Boy'.obs;
  List<String> dropdownList = [
    'Boy',
    'Girl'
  ];

  bool validation() {
    if (dormitoryNameController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Dormitory Name');
    }

    if (dormitoryIntake.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Intake');
    }

    if (dormitoryAddress.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Address');
    }

    return true;
  }
}
