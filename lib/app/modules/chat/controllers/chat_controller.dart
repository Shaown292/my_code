
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  RxBool isSearching = false.obs;
  RxBool singleChatLoader = false.obs;
  RxBool groupChatLoader = false.obs;
  RxBool isActive = true.obs;
  TabController? tabController;
  Rx<ChatStatusModel> dropdownValue = ChatStatusModel(statusColor: 0xFF12AE01, name: "ACTIVE").obs;


  List<String> chatType = <String>[
    'Chat',
    'Group Chat',

  ];

  List<ChatStatusModel> activeStatusList =  [
   ChatStatusModel(statusColor: 0xFF12AE01, name: "ACTIVE"),
   ChatStatusModel(statusColor: 0xFFE1E2EC, name: "INACTIVE"),
   ChatStatusModel(statusColor: 0xFFF60003, name: "BUSY"),
   ChatStatusModel(statusColor: 0xFFF99F15, name: "AWAY"),
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


@override
  void onInit() {

    dropdownValue.value = activeStatusList.first;

    super.onInit();
  }


}

class ChatStatusModel {
  final int statusColor;
  final String name;
  ChatStatusModel({required this.statusColor, required this.name});

}


