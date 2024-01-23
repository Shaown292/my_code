import 'package:get/get.dart';

class StudentClassController extends GetxController {

  RxInt titleBackgroundColor = (-1).obs;
  RxBool isJitsiTapped = false.obs;
  RxBool isZoomTapped = false.obs;
  int previousId = -1;
}
