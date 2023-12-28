import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/chat/pusher_controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/conversation_model/single_chat_list_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/api_urls.dart';

class SingleChatController extends GetxController {
  PusherController pusherController = Get.put(PusherController());
  GlobalRxVariableController globalRxVariableController = Get.find();
  TextEditingController sendTextController = TextEditingController();

  Rx<File> singleChatPickImage = File('').obs;
  RxBool singleChatSendLoader = false.obs;
  RxBool isLoading = false.obs;
  RxInt toUserId = 0.obs;

  Future<SingleChatListResponseModel> singleChatSend() async {
    try {
      singleChatSendLoader.value = true;

      debugPrint('${Uri.parse(InfixApi.sendSingleChat)}');
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.sendSingleChat));
      request.headers.addAll(GlobalVariable.header);

      if (singleChatPickImage.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'file_attach', singleChatPickImage.value.path));
      }

      request.fields['message'] = sendTextController.text;
      request.fields['from_user_id'] =
          globalRxVariableController.userId.value.toString();
      request.fields['to_user_id'] = toUserId.value.toString();

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      SingleChatListResponseModel singleChatListResponseModel =
          SingleChatListResponseModel.fromJson(json.decode(responseBody));

      if (singleChatListResponseModel.success == true) {
        singleChatSendLoader.value = false;
        sendTextController.clear();
        singleChatPickImage.value = File('');

        singleConversationList.add(singleChatListResponseModel.data!.first);
        singleConversationList.refresh();

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

    return SingleChatListResponseModel();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      singleChatPickImage.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'canceled file selection');
      debugPrint("User canceled file selection");
    }
  }

  bool validation() {
    if (sendTextController.text.isEmpty &&
        singleChatPickImage.value.path.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter something');
      return false;
    }
    return true;
  }

  RxList<SingleConversationListData> singleConversationList =
      <SingleConversationListData>[].obs;

  Future<SingleChatListResponseModel> getChtConversationList({required int userId}) async {
    try {
      isLoading.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.getSingleChatList(userId: userId),
          header: GlobalVariable.header);

      SingleChatListResponseModel singleChatListResponseModel =
          SingleChatListResponseModel.fromJson(response);

      if (singleChatListResponseModel.success == true) {
        isLoading.value = false;

        if (singleChatListResponseModel.data!.isNotEmpty) {
          for (var element in singleChatListResponseModel.data!) {
            singleConversationList.add(element);
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
    return SingleChatListResponseModel();
  }

  @override
  void onInit() {
    toUserId.value = Get.arguments['to_user_id'];
    getChtConversationList(userId: toUserId.value);
    pusherController.chatOpenSingle(
      authUserId: globalRxVariableController.userId.value!,
      chatListId: toUserId.value,
    );

    super.onInit();
  }
}
