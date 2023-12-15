import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

class ChildHomeController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  HomeController homeController = Get.find();

  List<HomeTileModelClass> homeTileList = studentList;
  final selectIndex = RxInt(-1);

  @override
  void onInit() {

    homeController.getStudentRecord(studentId: globalRxVariableController.studentId.value!);
    super.onInit();
  }

}
