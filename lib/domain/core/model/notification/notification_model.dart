class NotificationModel {
  bool? success;
  Data? data;
  String? message;

  NotificationModel({this.success, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<UnreadNotifications>? unreadNotifications;
  int? unreadNotificationsCount;

  Data({this.unreadNotifications, this.unreadNotificationsCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['unread_notifications'] != null) {
      unreadNotifications = <UnreadNotifications>[];
      json['unread_notifications'].forEach((v) {
        unreadNotifications!.add(new UnreadNotifications.fromJson(v));
      });
    }
    unreadNotificationsCount = json['unread_notifications_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.unreadNotifications != null) {
      data['unread_notifications'] =
          this.unreadNotifications!.map((v) => v.toJson()).toList();
    }
    data['unread_notifications_count'] = this.unreadNotificationsCount;
    return data;
  }
}

class UnreadNotifications {
  String? message;
  String? createdAt;

  UnreadNotifications({this.message, this.createdAt});

  UnreadNotifications.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}
