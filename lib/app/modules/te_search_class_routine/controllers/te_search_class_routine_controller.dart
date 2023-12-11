import 'package:get/get.dart';

class TeSearchClassRoutineController extends GetxController {

  RxString classInitValue = "One".obs;
  RxList<String> classList = ['One', 'Two', 'Three'].obs ;
  RxInt classId = 0.obs;

  RxString sectionInitValue = "A".obs;
  RxList<String> sectionList = ['A', 'V', 'D'].obs ;
  RxInt sectionId = 0.obs;
}
