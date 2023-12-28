class GroupChatListResponseModel {
  bool? success;
<<<<<<<< HEAD:lib/domain/core/model/chat/group_chat_user_list_response_model/group_chat_user_list_response_model.dart
  List<GroupChatUserListData>? data;
========
  List<GroupChatData>? data;
>>>>>>>> dev_shaown:lib/domain/core/model/chat/group_chat_list_response_model/group_chat_list_response_model.dart
  String? message;

  GroupChatListResponseModel({this.success, this.data, this.message});

  GroupChatListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
<<<<<<<< HEAD:lib/domain/core/model/chat/group_chat_user_list_response_model/group_chat_user_list_response_model.dart
      data = <GroupChatUserListData>[];
      json['data'].forEach((v) {
        data!.add(GroupChatUserListData.fromJson(v));
========
      data = <GroupChatData>[];
      json['data'].forEach((v) {
        data!.add(GroupChatData.fromJson(v));
>>>>>>>> dev_shaown:lib/domain/core/model/chat/group_chat_list_response_model/group_chat_list_response_model.dart
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

<<<<<<<< HEAD:lib/domain/core/model/chat/group_chat_user_list_response_model/group_chat_user_list_response_model.dart
class GroupChatUserListData {
  String? id;
  String? name;
  String? image;
  int? activeStatus;
  String? lastMessage;
  String? lastMessageTime;
  int? countConversation;

  GroupChatUserListData(
      {this.id,
        this.name,
        this.image,
        this.activeStatus,
        this.lastMessage,
        this.lastMessageTime,
        this.countConversation});

  GroupChatUserListData.fromJson(Map<String, dynamic> json) {
    id = json['group_id'];
    name = json['name'];
    image = json['image'];
    activeStatus = json['active_status'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    countConversation = json['count_conversation'];
========
class GroupChatData {
  int? threadId;
  int? messageId;
  String? message;
  int? status;
  int? messageType;
  String? file;
  String? originalFileName;
  bool? sender;
  bool? receiver;

  GroupChatData(
      {this.threadId,
        this.messageId,
        this.message,
        this.status,
        this.messageType,
        this.file,
        this.originalFileName,
        this.sender,
        this.receiver});

  GroupChatData.fromJson(Map<String, dynamic> json) {
    threadId = json['thread_id'];
    messageId = json['message_id'];
    message = json['message'];
    status = json['status'];
    messageType = json['message_type'];
    file = json['file'];
    originalFileName = json['original_file_name'];
    sender = json['sender'];
    receiver = json['receiver'];
>>>>>>>> dev_shaown:lib/domain/core/model/chat/group_chat_list_response_model/group_chat_list_response_model.dart
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thread_id'] = threadId;
    data['message_id'] = messageId;
    data['message'] = message;
    data['status'] = status;
    data['message_type'] = messageType;
    data['file'] = file;
    data['original_file_name'] = originalFileName;
    data['sender'] = sender;
    data['receiver'] = receiver;
    return data;
  }
}
