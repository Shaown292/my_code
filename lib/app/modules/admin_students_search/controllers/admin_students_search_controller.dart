import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminStudentsSearchController extends GetxController {

  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();


  RxString classValue = "1".obs ;
  RxList<String> classList = [
    "1",
    '2',
    "3",
    '4',
  ].obs ;
}
