import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class AdminAttendanceController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> adminAttendanceTileList = [

    HomeTileModelClass(icon: ImagePath.adminClassAttendance, title: 'Class Atten', value: 'Class Attendance Search'),
    HomeTileModelClass(icon: ImagePath.adminClassAttendance, title: 'Subject Atten', value: 'Subject Attendance Search'),
    HomeTileModelClass(icon: ImagePath.adminClassAttendance, title: 'Search Atten', value: 'Class Attendance Search Individual'),
    HomeTileModelClass(icon: ImagePath.adminClassAttendance, title: 'Search Sub Atten', value: 'Subject Attendance Search Individual'),
  ];
}
