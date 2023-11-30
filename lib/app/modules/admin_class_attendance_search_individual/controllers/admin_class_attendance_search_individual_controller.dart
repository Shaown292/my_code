import 'package:flutter_single_getx_api_v2/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class AdminClassAttendanceSearchIndividualController extends GetxController {

  LoadingController loadingController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController = Get.put(AdminStudentsSearchController());
}
