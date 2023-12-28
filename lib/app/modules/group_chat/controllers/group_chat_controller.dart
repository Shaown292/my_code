import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat_search/controllers/chat_search_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/group_chat_list_response_model/group_chat_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/group_chat_member_list_response_model/group_chat_member_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/group_chat_user_list_response_model/group_chat_user_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GroupChatController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  ChatSearchController chatSearchController = Get.put(ChatSearchController()) ;
  TextEditingController sendTextController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();
  ChatController chatController = Get.find();
  GroupChatUserData? groupChatListData ;

  RxList<GroupChatMemberListData> groupChatMemberList = <GroupChatMemberListData>[].obs;
  RxList<GroupChatData> groupChatData = <GroupChatData>[].obs;

  Rx<File> groupChatPickImage  = File('').obs;
  RxBool singleChatSendLoader = false.obs;
  RxString groupId = "".obs;
  RxBool groupMemberListLoader = false.obs;
  RxBool groupChatDataLoader = false.obs ;
  RxBool deleteChatLoader = false.obs ;
  RxBool addMemberLoader = false.obs ;
  RxBool removeMemberLoader = false.obs ;
  RxBool checkboxSelect = false.obs;

  RxList <String> userList = <String>[].obs;


  /// Pick a file for sending
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      groupChatPickImage.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'canceled file selection');
      debugPrint("User canceled file selection");
    }
  }

  /// Clear check box data
  void clearCheckboxData() {
    for (var element in chatSearchController.searchChatDataList) {

      element.isSelected = false;

    }

    chatSearchController.searchChatDataList.refresh();

}

  /// Group chat Member List
  Future<GroupChatMemberListResponseModel?> getGroupChatMemberList({required String groupId}) async {
    groupChatMemberList.clear();
    try {
      groupMemberListLoader.value = true;

      final response = await BaseClient().getData(
        url: "https://spondan.com/infixedu/api/v2/admin-group-members?group_id=$groupId",
        header: GlobalVariable.header,
      );

      GroupChatMemberListResponseModel groupChatMemberListResponseModel = GroupChatMemberListResponseModel.fromJson(response);
      if (groupChatMemberListResponseModel.success == true) {
        groupMemberListLoader.value = false;
        if (groupChatMemberListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
          i < groupChatMemberListResponseModel.data!.length;
          i++) {
            groupChatMemberList
                .add(groupChatMemberListResponseModel.data![i]);
          }
        }
      } else{
        groupMemberListLoader.value = false;
        showBasicFailedSnackBar(message: groupChatMemberListResponseModel.message ?? AppText.somethingWentWrong,);
      }
    } catch (e, t) {
      groupMemberListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      groupMemberListLoader.value = false;
    }
    return GroupChatMemberListResponseModel();
  }

  /// Group Chat data
  Future<GroupChatListResponseModel?> getGroupChatData({required String groupId}) async {
    groupChatData.clear();
    try {
      groupChatDataLoader.value = true;

      final response = await BaseClient().getData(
        url: "https://spondan.com/infixedu/api/v2/admin-group-chats?group_id=$groupId",
        header: GlobalVariable.header,
      );

      GroupChatListResponseModel groupChatListResponseModel = GroupChatListResponseModel.fromJson(response);
      if (groupChatListResponseModel.success == true) {
        groupChatDataLoader.value = false;
        if (groupChatListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
          i < groupChatListResponseModel.data!.length;
          i++) {
            groupChatData
                .add(groupChatListResponseModel.data![i]);
          }
        }
      } else{
        groupChatDataLoader.value = false;
        showBasicFailedSnackBar(message: groupChatListResponseModel.message ?? AppText.somethingWentWrong,);
      }
    } catch (e, t) {
      groupChatDataLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      groupChatDataLoader.value = false;
    }
    return GroupChatListResponseModel();
  }

 /// Group Add Member
  Future<void> groupAddMember(
      {required String groupId, required List<String> userList}) async {
    try {
      addMemberLoader.value = true;
      final response = await BaseClient().postData(
          url: "https://spondan.com/infixedu/api/v2/admin-add-group-member",
          payload: {
            "group_id" : groupId,
            "user_id" : userList,
          },
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        addMemberLoader.value = false;
        const SecondaryLoadingWidget();
        userList.clear();
        // Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Member Added');
      } else {
        addMemberLoader.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      addMemberLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      addMemberLoader.value = false;
    }
  }


  /// Group Member Leave
  Future<void> groupMemberLeave(
      {required String groupId}) async {
    try {
      addMemberLoader.value = true;
      final response = await BaseClient().postData(
          url: "https://spondan.com/infixedu/api/v2/admin-group-leave?group_id=$groupId",

          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        addMemberLoader.value = false;

        const SecondaryLoadingWidget();
        chatController.groupChatList.removeWhere((element) => element.groupId == groupId);
        chatController.groupChatList.refresh();
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Group Leave');
      } else {
        addMemberLoader.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      addMemberLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      addMemberLoader.value = false;
    }
  }

  /// Group chat Send a Text or File
  Future<void> groupChatSend() async {
    try {
      singleChatSendLoader.value = true;
      final request =
      http.MultipartRequest('POST', Uri.parse("https://spondan.com/infixedu/api/v2/admin-group-chat-send"));
      request.headers.addAll(GlobalVariable.header);

      if (groupChatPickImage.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'file_attach', groupChatPickImage.value.path));
      }

      request.fields['message'] = sendTextController.text;
      request.fields['user_id'] = globalRxVariableController.userId.value.toString();
      request.fields['group_id'] = groupChatListData!.groupId!.toString();


      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        singleChatSendLoader.value = false;
        sendTextController.clear();
        groupChatPickImage.value = File('');
        showBasicSuccessSnackBar(message: decodedResponse['message']);
      } else {
        singleChatSendLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      singleChatSendLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      singleChatSendLoader.value = false;
    }
  }

  /// Delete Single Message
  Future<void> deleteSingleChat(
      {required int threadId, required int index}) async {
    try {
      deleteChatLoader.value = true;
      final response = await BaseClient().postData(
          url: "https://spondan.com/infixedu/api/v2/admin-group-chat-remove?thread_id=$threadId",
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteChatLoader.value = false;
        Get.back();
        groupChatData.removeAt(index);
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Data deleted');
      } else {
        deleteChatLoader.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      deleteChatLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteChatLoader.value = false;
    }
  }

  /// Forward a message
  Future<void> forwardSingleChat({required String groupId, required String messageId, required String message, required String userId }) async {
    try {
      deleteChatLoader.value = true;
      final response = await BaseClient().postData(
          url: "https://spondan.com/infixedu/api/v2/admin-group-chat-forward",
          payload: {
            "group_id" : groupId,
            "message_id" : messageId,
            "message" : message,
            "user_id" : userId,
          },
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteChatLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Text Forward Successfully ');
      } else {
        deleteChatLoader.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      deleteChatLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteChatLoader.value = false;
    }
  }

  /// Remove a member from group
  Future<void> removeSingleMemberFromGroup(
      {required String groupId, required int userId}) async {
    try {
      removeMemberLoader.value = true;
      final response = await BaseClient().postData(
          url: "https://spondan.com/infixedu/api/v2/admin-group-member-delete?group_id=$groupId&user_id=$userId",
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        removeMemberLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Member removed');
      } else {
        removeMemberLoader.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      removeMemberLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      removeMemberLoader.value = false;
    }
  }



  /// Validation before sending a text
  bool validation() {
    if (sendTextController.text.isEmpty && groupChatPickImage.value.path.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter something');
      return false;
    }
    return true;
  }



  @override
  void onInit() {
    groupChatListData = Get.arguments["group_id"];
    groupId.value = groupChatListData!.groupId!;
    getGroupChatMemberList(groupId: groupId.value);
    getGroupChatData(groupId: groupId.value);
    super.onInit();
  }
}
