import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

class AdminAddRoomController extends GetxController {

  TextEditingController roomNoController = TextEditingController();
  TextEditingController numberOfBedController = TextEditingController();
  TextEditingController costPerBedController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  RxString dormitoryValue = 'Sir Isaac Newton Hostel'.obs;
  List<String> dormitoryList = [
    'Sir Isaac Newton Hostel',
    'Sir Jackson'
  ];

  RxString roomTypeValue = 'Single'.obs;
  List<String> roomTypeValueList = [
    'Single',
    'Double'
  ];


  bool validation() {
    if (roomNoController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Room No');
    }

    if (numberOfBedController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Number of Bed');
    }

    if (costPerBedController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Cost Per Bed');
    }

    return true;
  }
}
