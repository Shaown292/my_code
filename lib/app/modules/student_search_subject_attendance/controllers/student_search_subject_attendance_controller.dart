import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class StudentSearchSubjectAttendanceController extends GetxController {

  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();
  final selectIndex = RxInt(0);
}
