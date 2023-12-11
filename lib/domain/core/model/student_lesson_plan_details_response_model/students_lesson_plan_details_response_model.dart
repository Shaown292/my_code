class StudentLessonPlanDetailsResponseModel {
  bool? success;
  StudentLessonPlanDetailsData? data;
  String? message;

  StudentLessonPlanDetailsResponseModel(
      {this.success, this.data, this.message});

  StudentLessonPlanDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? StudentLessonPlanDetailsData.fromJson(json['data'])
        : null;
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
  List<String>? topic;
  List<String>? subtopic;
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
    topic = json['topic'].cast<String>();
    subtopic = json['subtopic'].cast<String>();
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
    data['topic'] = topic;
    data['subtopic'] = subtopic;
    data['lecture_youtube_link'] = lectureYoutubeLink;
    data['document'] = document;
    data['note'] = note;
    data['status'] = status;
    return data;
  }
}
