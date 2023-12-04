import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

class AdminAddBookController extends GetxController {

  TextEditingController titleTextController = TextEditingController();
  TextEditingController bookNumberTextController = TextEditingController();
  TextEditingController isbnTextController = TextEditingController();
  TextEditingController publisherNameTextController = TextEditingController();
  TextEditingController authorNameTextController = TextEditingController();
  TextEditingController rackNumberTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  RxString categoryInitValue = "Horror".obs;
  RxList<String> categoryList = [
    "Horror",
    "Comedy",
    "Novel"
  ].obs;

  RxString subjectInitValue = "Child".obs;
  RxList<String> subjectList = [
    "Child",
    "Adult",
    "Teen"
  ].obs;

  bool validation() {
    if (titleTextController.text == '') {
      showBasicFailedSnackBar(message: 'Add Book Title');
    }
    if(categoryList.isEmpty){
      showBasicFailedSnackBar(message: 'Select Book Category .');
    }
    if(subjectList.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Book Category .');
    }

    return true;
  }
}
