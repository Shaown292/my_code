import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class TeHomeworkController extends GetxController {

  final selectIndex = RxInt(-1);


  List<HomeTileModelClass> teacherHomeworkTileList = [
    HomeTileModelClass(icon: ImagePath.add, title: 'Add Homework', value: 'Add Homework'),
    HomeTileModelClass(icon: ImagePath.list, title: 'Homework List', value: 'Homework List'),
  ];
}
