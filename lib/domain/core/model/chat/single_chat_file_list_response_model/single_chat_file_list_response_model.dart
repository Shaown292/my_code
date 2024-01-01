class SingleChatFileListResponseModel {
  bool? success;
  List<SingleChatFileList>? data;
  String? message;

  SingleChatFileListResponseModel({this.success, this.data, this.message});

  SingleChatFileListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SingleChatFileList>[];
      json['data'].forEach((v) {
        data!.add(SingleChatFileList.fromJson(v));
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

class SingleChatFileList {
  int? messageId;
  String? file;
  String? originalFileName;

  SingleChatFileList({this.messageId, this.file, this.originalFileName});

  SingleChatFileList.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    file = json['file'];
    originalFileName = json['original_file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['file'] = file;
    data['original_file_name'] = originalFileName;
    return data;
  }
}
