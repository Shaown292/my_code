import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class AdminLibraryController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> adminFeesTileList = [

    HomeTileModelClass(icon: ImagePath.add, title: 'Add Book', value: 'Add Book'),
    HomeTileModelClass(icon: ImagePath.list, title: 'Book List', value: 'Book List'),
    HomeTileModelClass(icon: ImagePath.add, title: 'Add Member', value: 'Add Member'),

  ];
}
