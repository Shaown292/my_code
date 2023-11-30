import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class LeaveController extends GetxController {

  final selectIndex = RxInt(-1);


  List<HomeTileModelClass> leaveTileList = [
    HomeTileModelClass(icon: ImagePath.applyLeave, title: 'Apply Leave', value: 'Apply Leave'),
    HomeTileModelClass(icon: ImagePath.list, title: 'Leave List', value: 'Leave List'),
  ];

}
