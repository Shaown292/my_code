class ChatAuthActiveStatusResponseModel {
  bool? success;
  List<Data>? data;
  String? message;

  ChatAuthActiveStatusResponseModel({this.success, this.data, this.message});

  ChatAuthActiveStatusResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? status;
  String? color;
  String? statusInfo;

  Data({this.status, this.color, this.statusInfo});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    color = json['color'];
    statusInfo = json['status_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['color'] = color;
    data['status_info'] = statusInfo;
    return data;
  }
}
