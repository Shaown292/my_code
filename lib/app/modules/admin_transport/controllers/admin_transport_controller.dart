import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class AdminTransportController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> adminFeesTileList = [
    HomeTileModelClass(icon: ImagePath.studentTransport, title: 'Route', value: 'Route'),
    HomeTileModelClass(icon: ImagePath.studentTransport, title: 'Vehicle', value: 'Vehicle'),
    HomeTileModelClass(icon: ImagePath.add, title: 'Assign Vehicle', value: 'Assign Vehicle'),
    HomeTileModelClass(icon: ImagePath.studentTransport, title: 'Transport', value: 'Transport Details'),
  ];
}
