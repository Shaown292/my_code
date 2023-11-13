
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  RxBool isSearching = false.obs;
  RxBool isActive = true.obs;
  LoadingController loadingController = Get.find();
  TabController? tabController;
  RxString dropdownValue = "ACTIVE".obs;


  List<String> activeStatus = <String>[
    'ACTIVE',
    'INACTIVE',
    'AWAY',
    'BUSY'
  ];

  List<String> chatType = <String>[
    'Chat',
    'Group Chat',
  
  ];

  List<String> activeStatusColor = <String> [

  ];


  String? changeActiveStatusColor (){
    String colorCode = '';
    String status = dropdownValue.value;
    if (status == 'ACTIVE') {
      colorCode = '0xFF12AE01';
    } else if (status == 'INACTIVE') {
      colorCode = '0xFFE1E2EC';
    } else if (status == 'AWAY') {
      colorCode = '0xFFF99F15';
    } else {
      colorCode = '0xFFF60003';
    }
    return colorCode;
  }


}
