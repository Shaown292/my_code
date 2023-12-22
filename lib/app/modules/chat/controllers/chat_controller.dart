
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/group_chat_list_response_model/group_chat_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/single_chat_list_response_model/single_chat_list_response_model.dart';
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

  RxBool singleChatListLoader = false.obs;
  List<SingleChatListData> singleChatList = [];
  Future<SingleChatListResponseModel?> getSingleChatList() async {
    singleChatList.clear();
    try {
      singleChatListLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getSingleChatList,
        header: GlobalVariable.header,
      );

@override
  void onInit() {

    dropdownValue.value = activeStatusList.first;

    super.onInit();
  }


      SingleChatListResponseModel singleChatListResponseModel =
      SingleChatListResponseModel.fromJson(response);
      if (singleChatListResponseModel.success == true) {
        singleChatListLoader.value = false;
        if (singleChatListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
          i < singleChatListResponseModel.data!.length;
          i++) {
            singleChatList
                .add(singleChatListResponseModel.data![i]);
          }
        }
      } else{
        singleChatListLoader.value = false;
        showBasicFailedSnackBar(message: singleChatListResponseModel.message ?? AppText.somethingWentWrong,);
      }
    } catch (e, t) {
      singleChatListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      singleChatListLoader.value = false;
    }
    return SingleChatListResponseModel();
  }


  RxBool groupChatListLoader = false.obs;
  List<GroupChatListData> groupChatList = [];
  Future<GroupChatListResponseModel?> getGroupChatList() async {
    groupChatList.clear();
    try {
      groupChatListLoader.value = true;

      final response = await BaseClient().getData(
        url:  InfixApi.getGroupChatList,
        header: GlobalVariable.header,
      );


      GroupChatListResponseModel groupChatListResponseModel = GroupChatListResponseModel.fromJson(response);
      if (groupChatListResponseModel.success == true) {
        groupChatListLoader.value = false;
        if (groupChatListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
          i < groupChatListResponseModel.data!.length;
          i++) {
            groupChatList
                .add(groupChatListResponseModel.data![i]);
          }
        }
      } else{
        groupChatListLoader.value = false;
        showBasicFailedSnackBar(message: groupChatListResponseModel.message ?? AppText.somethingWentWrong,);
      }
    } catch (e, t) {
      groupChatListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      groupChatListLoader.value = false;
    }
    return GroupChatListResponseModel();
  }

  String formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'a few moments ago';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes != 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hour${hours != 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return '$days day${days != 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months month${months != 1 ? 's' : ''} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years year${years != 1 ? 's' : ''} ago';
    }
  }



  RxInt tabIndex = 0.obs;

  @override
  void onInit() {
    dropdownValue.value = activeStatusList.first;
   getSingleChatList();
   getGroupChatList();
    super.onInit();
  }
}

class ChatStatusModel {
  final int statusColor;
  final String name;

  ChatStatusModel({required this.statusColor, required this.name});

}




