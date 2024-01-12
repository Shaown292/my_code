class ZoomMeetingListResponseModel {
  bool? success;
  List<ZoomMeetingList>? data;
  String? message;

  ZoomMeetingListResponseModel({this.success, this.data, this.message});

  ZoomMeetingListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ZoomMeetingList>[];
      json['data'].forEach((v) {
        data!.add(ZoomMeetingList.fromJson(v));
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

class ZoomMeetingList {
  String? meetingId;
  String? topic;
  double? duration;
  String? startTime;

  ZoomMeetingList({this.meetingId, this.topic, this.duration, this.startTime});

  ZoomMeetingList.fromJson(Map<String, dynamic> json) {
    meetingId = json['meeting_id'];
    topic = json['topic'];
    duration = json['duration'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meeting_id'] = meetingId;
    data['topic'] = topic;
    data['duration'] = duration;
    data['start_time'] = startTime;
    return data;
  }
}