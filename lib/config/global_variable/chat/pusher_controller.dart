import 'dart:convert';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/controllers/single_chat_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/chat/conversation_model/single_chat_list_response_model.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherController extends GetxController {
  // final GlobalRxVariableController globalRxVariableController = Get.find();
  // final SingleChatController _chatController = Get.find();

  int? chatOpenId;
  String? chatGroupId;

  // RxBool isTyping = false.obs;
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  onConnectPressed() async {
    print('calling connect ');
    try {
      final pusher = PusherChannelsFlutter.getInstance();
      // await pusher.init(
      //     apiKey: '945f5ae54c6bad96fb44',
      //     cluster: 'ap2'
      // );
      // final myChannel = await pusher.subscribe(
      //     channelName: "my-channel",
      //     onEvent: (event) {
      //       print("Got channel event: $event");
      //     }
      // );
      // await pusher.connect();

      print('try::::::::::::');
      await pusher.init(
        apiKey: '945f5ae54c6bad96fb44',
        cluster: 'ap2',
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onAuthorizer: onAuthorizer,
        logToConsole: true,
        maxReconnectionAttempts: 0,
      );

      // await pusher.subscribe(channelName: 'presence-chatbox',
      //    onSubscriptionSucceeded: (channelName, data) {
      //   print("Subscribed to $channelName");
      //   // print("I can now access me: ${myChannel.me}");
      //   // print("And here are the channel members: ${myChannel.members}");
      // } ,
      //    onEvent: (event) {
      //   print("Event received: $event");
      // },);
      // await pusher.connect();
    } catch (e, t) {
      print('catch::::::::::::');
      debugPrint("ERROR: $e");
      debugPrint("ERROR: $t");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("Connection: $currentState");
  }

  void onError(String? message, int? code, dynamic e) {
    debugPrint("onError: $message code: $code exception: $e");
  }

  // void onEvent(PusherEvent event) {
  //   // debugPrint("onEvent: $event");
  //   if (event.eventName == "client-single-typing") {
  //     // isTyping(true);
  //
  //     Future.delayed(const Duration(seconds: 1), () {
  //       // isTyping(false);
  //     });
  //   }
  //   if (event.channelName == 'private-single-chat' '.$chatOpenId' ||
  //       event.channelName ==
  //           'private-single-chat' '.${Get.find<SingleChatController>().toUserId.value}') {
  //     final da = jsonDecode(event.data);
  //     SingleChatListResponseModel chatMessage = SingleChatListResponseModel.fromJson(da['message']);
  //
  //   }
  //
  //   // if (event.channelName == 'private-group-chat' '.$chatGroupId' &&
  //   //     event.eventName != 'client-typing') {
  //   //   final da = jsonDecode(event.data);
  //   //   ChatGroupPusher chatMessage = ChatGroupPusher.fromJson(da);
  //   //
  //   //   GroupThread groupThread = GroupThread(
  //   //     id: chatMessage.thread?.id,
  //   //     userId: chatMessage.user?.id,
  //   //     conversationId: chatMessage.conversation?.id,
  //   //     groupId: chatMessage.group?.id  ??'',
  //   //     readAt: chatMessage.thread?.readAt,
  //   //     createdAt: chatMessage.conversation?.createdAt ?? DateTime.now(),
  //   //     conversation: chatMessage.conversation ?? ChatMessage(),
  //   //     user: chatMessage.user ?? ChatUser(),
  //   //   );
  //   //
  //   //   groupSource?.insert(0, groupThread);
  //   //   groupSource?.onStateChanged(groupSource!);
  //   // }
  // }

  void onEvent(PusherEvent event) {
    print("onEvent: $event");
    print(
        "onEvent Chanel ID ::::: private-single-chat.${Get.find<SingleChatController>().toUserId}");
    // final data = json.decode(event.data as String) as Map<String, dynamic>;
    // event.channelName == 'private-single-chat.${ Get.find<SingleChatController>().toUserId}-${Get.find<GlobalRxVariableController>().userId.value}'
    if (event.channelName ==
        'private-single-chat.${Get.find<GlobalRxVariableController>().userId.value}-${Get.find<SingleChatController>().toUserId}') {
      final data = jsonDecode(event.data);
      // print('On Event :: ${data["message"]["message"]}');

      Get.find<SingleChatController>()
          .singleConversationList
          .add(SingleConversationListData(
            messageId: data["message"]["id"],
            message: data["message"]["message"],
            status: data["message"]["status"],
            messageType: data["message"]["message_type"],
            file: data["message"]["file_name"],
            originalFileName: data["message"]["original_file_name"],
            reply: data["message"]["reply"],
            sender: Get.find<GlobalRxVariableController>().userId.value ==
                data["message"]["from_id"],
            receiver: Get.find<GlobalRxVariableController>().userId.value !=
                data["message"]["from_id"],
          ));
      Get.find<SingleChatController>().singleConversationList.refresh();
    } else if (event.channelName ==
        'private-group-chat.${Get.find<GlobalRxVariableController>().userId.value}-${Get.find<SingleChatController>().toUserId}') {
      final data = jsonDecode(event.data);
      // print('On Event :: ${data["message"]["message"]}');

      Get.find<SingleChatController>()
          .singleConversationList
          .add(SingleConversationListData(
            messageId: data["message"]["id"],
            message: data["message"]["message"],
            status: data["message"]["status"],
            messageType: data["message"]["message_type"],
            file: data["message"]["file_name"],
            originalFileName: data["message"]["original_file_name"],
            reply: data["message"]["reply"],
            sender: Get.find<GlobalRxVariableController>().userId.value ==
                data["message"]["from_id"],
            receiver: Get.find<GlobalRxVariableController>().userId.value !=
                data["message"]["from_id"],
          ));
      Get.find<SingleChatController>().singleConversationList.refresh();
    }

    // final message = SingleChatListResponseModel.fromJson(data["message"]);
    // print('On Event Message :: ${message.data!.first.message}');
    if (event.eventName == "client-single-typing") {
      // isTyping(true);

      Future.delayed(const Duration(seconds: 1), () {
        // isTyping(false);
      });
    }

    // final data = json.decode(event.data as String) as Map<String, dynamic>;
    // final message = SingleChatListResponseModel.fromJson(data);
    // print('On Event Message :: ${message.data!.first.message}');

    // Get.find<SingleChatController>().singleConversationList.add(message.data!.first);
    // refresh();
    //
    // for(int i = 0; i < Get.find<SingleChatController>().singleConversationList.length; i++){
    //   print(Get.find<SingleChatController>().singleConversationList[i].message);
    // }
    // print('object:::::::::');
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    debugPrint("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    debugPrint("Me::::::::: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    debugPrint("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    debugPrint("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    debugPrint("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    debugPrint("onMemberRemoved: $channelName user: $member");
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    print('Socket ID ::: $socketId ::: Channel Name :: $channelName');
    try {
      Map data = {
        'socket_id': socketId,
        'channel_name': channelName,
      };

      debugPrint(data.toString());

      var result = await http.post(
        Uri.parse(InfixApi.chatBroadCastAuth),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        },
        body: 'socket_id=$socketId&channel_name=$channelName',
      );
      return jsonDecode(result.body);
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  chatOpenSingle({required int authUserId, required int chatListId}) async {
    try {
      // await pusher.subscribe(
      //     channelName: 'private-single-chat' '.$chatListId');
      // await pusher.connect();
      await pusher.subscribe(
          channelName: 'private-single-chat.$authUserId-$chatListId');
      // channelName: 'private-single-chat.$chatListId-$chatOpenId');
      await pusher.connect();
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  chatOpenGroup({required int authUserId, required String chatListId}) async {
    try {
      await pusher.subscribe(
          channelName: 'private-group-chat.$authUserId-$chatListId');
      await pusher.connect();
    } catch (e, t) {
      debugPrint("ERROR: $e");
      debugPrint("ERROR: $t");
    }
  }

  @override
  void onInit() {
    onConnectPressed();
    super.onInit();
  }
}
