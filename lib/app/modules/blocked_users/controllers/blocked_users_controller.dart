import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/blocked_users_list_response_model/blocked_users_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class BlockedUsersController extends GetxController {

  ChatController chatController = Get.find();

  List<BlockedUsersData> blockedUsersData = [];
  RxBool blockedUsersDataLoader = false.obs;
  RxBool blockLoaded = false.obs;


  Future<BlockedUsersListResponseModel?> blockedUsersList() async {
    blockedUsersData.clear();
    try {
      blockedUsersDataLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.blockedChatUser,
        header: GlobalVariable.header,
      );

      BlockedUsersListResponseModel blockedUsersListResponseModel = BlockedUsersListResponseModel.fromJson(response);
      if (blockedUsersListResponseModel.success == true) {

        blockedUsersDataLoader.value = false;
        if (blockedUsersListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < blockedUsersListResponseModel.data!.length; i++) {
            blockedUsersData.add(blockedUsersListResponseModel.data![i]);
          }
        }
      } else {
        blockedUsersDataLoader.value = false;
        showBasicFailedSnackBar(
          message:
          blockedUsersListResponseModel.message ?? AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      blockedUsersDataLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      blockedUsersDataLoader.value = false;
    }
    return BlockedUsersListResponseModel();
  }

  /// Block a single user
  Future<void> blockSingleUser(
      {required String type, required int userId}) async {
    try {
      blockLoaded.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.blockSingleUser(type: type, userId: userId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
      PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        blockLoaded.value = false;
        chatController.singleChatList.clear();
        chatController.getSingleChatList();
        Get.back();

        showBasicSuccessSnackBar(
            message:
            postRequestResponseModel.message ?? 'operation successful');
      } else {
        blockLoaded.value = false;
        showBasicFailedSnackBar(
            message:
            postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      blockLoaded.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      blockLoaded.value = false;
    }
  }

  @override
  void onInit() {
    blockedUsersList();
    super.onInit();
  }
}
