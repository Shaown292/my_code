class StudentLessonPlanDetailsResponseModel {
  bool? success;
  StudentLessonPlanDetailsData? data;
  String? message;

  StudentLessonPlanDetailsResponseModel(
      {this.success, this.data, this.message});

  StudentLessonPlanDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? StudentLessonPlanDetailsData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class StudentLessonPlanDetailsData {
  String? classSection;
  String? subject;
  String? date;
  String? lesson;
  List<Topic>? topic;
  List<Subtopic>? subtopic;
  String? lectureYoutubeLink;
  String? document;
  String? note;
  bool? status;

  StudentLessonPlanDetailsData(
      {this.classSection,
        this.subject,
        this.date,
        this.lesson,
        this.topic,
        this.subtopic,
        this.lectureYoutubeLink,
        this.document,
        this.note,
        this.status});

  StudentLessonPlanDetailsData.fromJson(Map<String, dynamic> json) {
    classSection = json['class_section'];
    subject = json['subject'];
    date = json['date'];
    lesson = json['lesson'];
    if (json['topic'] != null) {
      topic = <Topic>[];
      json['topic'].forEach((v) {
        topic!.add(Topic.fromJson(v));
      });
    }
    if (json['subtopic'] != null) {
      subtopic = <Subtopic>[];
      json['subtopic'].forEach((v) {
        subtopic!.add(Subtopic.fromJson(v));
      });
    }
    lectureYoutubeLink = json['lecture_youtube_link'];
    document = json['document'];
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_section'] = classSection;
    data['subject'] = subject;
    data['date'] = date;
    data['lesson'] = lesson;
    if (topic != null) {
      data['topic'] = topic!.map((v) => v.toJson()).toList();
    }
    if (subtopic != null) {
      data['subtopic'] = subtopic!.map((v) => v.toJson()).toList();
    }
    data['lecture_youtube_link'] = lectureYoutubeLink;
    data['document'] = document;
    data['note'] = note;
    data['status'] = status;
    return data;
  }
}

class Topic {
  int? id;
  String? topicTitle;

  Topic({this.id, this.topicTitle});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicTitle = json['topic_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topic_title'] = topicTitle;
    return data;
  }
}

class Subtopic {
  int? id;
  String? subTopicTitle;

  Subtopic({this.id, this.subTopicTitle});

  Subtopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTopicTitle = json['sub_topic_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_topic_title'] = subTopicTitle;
    return data;
  }
}
