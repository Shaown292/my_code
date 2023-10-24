import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class ExaminationController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> examinationTileList = [
    HomeTileModelClass(icon: ImagePath.examinationSchedule, title: 'Schedule', value: 'Schedule'),
    HomeTileModelClass(icon: ImagePath.examinationResult, title: 'Result', value: 'Result'),
  ];
}
