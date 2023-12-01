import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminAddMemberController extends GetxController {

  TextEditingController idTextController = TextEditingController();

  RxString memberCategory = "Driver".obs;
  RxList<String> memberCategoryList = [
    "Driver",
    "Teacher",
    "Security Guard",
    "Librarian"
  ].obs;

  RxString memberName = "Sumon".obs;
  RxList<String> memberNameList = [
    "Sumon",
    "Sujon",
    "Sukhon",
    "Roton"
  ].obs;
}
