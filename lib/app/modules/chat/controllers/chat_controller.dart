
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  RxBool isSearching = false.obs;
  RxBool isActive = true.obs;
  LoadingController loadingController = Get.find();
  TabController? tabController;
  Rx<ChatStatusModel> dropdownValue =ChatStatusModel(name: "ACTIVE", statusColor: const Color(0xFF12AE01)).obs ;


  RxList<ChatStatusModel> activeStatus = <ChatStatusModel>[].obs;


  void getStatus (){
    for (int i = 0;
    i < activeStatusColor.length;
    i++) {
      activeStatus
          .add(activeStatusColor[i]);
      dropdownValue.value = activeStatusColor[0] ;
    }
  }

  List<String> chatType = <String>[
    'Chat',
    'Group Chat',

  ];

  List<ChatStatusModel> activeStatusColor =  [
   ChatStatusModel(statusColor: const Color(0xFF12AE01), name: "ACTIVE"),
   ChatStatusModel(statusColor: const Color(0xFFE1E2EC), name: "INACTIVE"),
  ];


  //  changeActiveStatusColor (){
  //   String colorCode = '';
  //   String status = dropdownValue.value;
  //   if (status == 'ACTIVE') {
  //     colorCode = '0xFF12AE01';
  //   } else if (status == 'INACTIVE') {
  //     colorCode = '0xFFE1E2EC';
  //   } else if (status == 'AWAY') {
  //     colorCode = '0xFFF99F15';
  //   } else {
  //     colorCode = '0xFFF60003';
  //   }
  //   return colorCode;
  // }



}

class ChatStatusModel {
  final Color statusColor;
  final String name;
  ChatStatusModel({required this.statusColor, required this.name});

}


