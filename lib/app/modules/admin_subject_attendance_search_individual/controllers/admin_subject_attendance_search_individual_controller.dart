import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchIndividualController extends GetxController {

  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  RxString classInitialValue = '1'.obs;
  RxString classNullValue = ''.obs;
  List<String> classList = [
    '1',
    '2',
    '3',
    '4'
  ];

  RxString sectionInitialValue = 'A'.obs;
  RxString sectionNullValue = ''.obs;
  List<String> sectionList = [
    'A',
    'B',
    'C',
    'D'
  ];

  RxString subjectInitialValue = 'Mat'.obs;
  RxString subjectNullValue = ''.obs;
  List<String> subjectList = [
    'Mat',
    'Eng',
    'Ban',
    'Phy'
  ];
}
