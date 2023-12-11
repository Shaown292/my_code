import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class TeLeaveController extends GetxController {

  final selectIndex = RxInt(-1);


  List<HomeTileModelClass> teacherLeaveTileList = [
    HomeTileModelClass(icon: ImagePath.add, title: 'Apply Leave', value: 'Apply Leave'),
    HomeTileModelClass(icon: ImagePath.list, title: 'Leave List', value: 'Leave List'),
  ];
}
