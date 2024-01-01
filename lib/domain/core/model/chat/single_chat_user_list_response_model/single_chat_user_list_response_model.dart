class SingleChatUserListResponseModel {
  bool? success;
  List<SingleChatUserListData>? data;
  String? message;

  SingleChatUserListResponseModel({this.success, this.data, this.message});

  SingleChatUserListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SingleChatUserListData>[];
      json['data'].forEach((v) {
        data!.add(SingleChatUserListData.fromJson(v));
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

class SingleChatUserListData {
  int? id;
  String? fullName;
  String? image;
  int? activeStatus;
  String? lastMessage;
  String? lastMessageTime;
  int? countConversation;

  SingleChatUserListData(
      {this.id,
        this.fullName,
        this.image,
        this.activeStatus,
        this.lastMessage,
        this.lastMessageTime,
        this.countConversation});

  SingleChatUserListData.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    fullName = json['full_name'];
    image = json['image'];
    activeStatus = json['active_status'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    countConversation = json['count_conversation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = id;
    data['full_name'] = fullName;
    data['image'] = image;
    data['active_status'] = activeStatus;
    data['last_message'] = lastMessage;
    data['last_message_time'] = lastMessageTime;
    data['count_conversation'] = countConversation;
    return data;
  }
}
