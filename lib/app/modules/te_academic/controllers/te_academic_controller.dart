import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class TeAcademicController extends GetxController {

  final selectIndex = RxInt(-1);


  List<HomeTileModelClass> teacherAcademicTileList = [
    HomeTileModelClass(icon: ImagePath.adminClass, title: 'My Routine', value: 'My Routine'),
    HomeTileModelClass(icon: ImagePath.studentLesson, title: 'Class Routine', value: 'Class Routine'),
    HomeTileModelClass(icon: ImagePath.studentSubjects, title: 'Subjects', value: 'Subjects'),
  ];
}
