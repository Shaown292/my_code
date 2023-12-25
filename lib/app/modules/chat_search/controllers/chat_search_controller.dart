import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/search_chat_user/search_chat_user.dart';
import 'package:get/get.dart';

class ChatSearchController extends GetxController {
  //TODO: Implement ChatSearchController

  TextEditingController searchController = TextEditingController();

  RxBool searchLoader = false.obs;
  RxList<SearchChatData> searchChatDataList = <SearchChatData>[].obs;
  Future<SearchChatUser?> getSearchChat(String searchKey) async {

    try {

      searchLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getChatUserSearch(keyword: searchKey),
        header: GlobalVariable.header,
      );

     SearchChatUser searchChatUser = SearchChatUser.fromJson(response);
      if(searchChatUser.success == true){
        searchLoader.value = false;
        if(searchChatUser.data!.isNotEmpty){
          for(int i = 0; i < searchChatUser.data!.length; i++) {
            searchChatDataList.add(searchChatUser.data![i]);
          }
        }
      }

    } catch (e, t) {
      searchLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchLoader.value = false;
    }
    return SearchChatUser();
  }
}
