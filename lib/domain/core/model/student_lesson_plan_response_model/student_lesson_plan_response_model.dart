class StudentLessonPlanResponseModel {
  bool? success;
  Data? data;
  String? message;

  StudentLessonPlanResponseModel({this.success, this.data, this.message});

  StudentLessonPlanResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? thisWeek;
  List<Weeks>? weeks;

  Data({this.thisWeek, this.weeks});

  Data.fromJson(Map<String, dynamic> json) {
    thisWeek = json['this_week'];
    if (json['weeks'] != null) {
      weeks = <Weeks>[];
      json['weeks'].forEach((v) {
        weeks!.add(Weeks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['this_week'] = thisWeek;
    if (weeks != null) {
      data['weeks'] = weeks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weeks {
  int? id;
  String? name;
  int? isWeekend;
  String? date;
  List<ClassRoutine>? classRoutine;

  Weeks({this.id, this.name, this.isWeekend, this.date, this.classRoutine});

  Weeks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isWeekend = json['isWeekend'];
    date = json['date'];
    if (json['classRoutine'] != null) {
      classRoutine = <ClassRoutine>[];
      json['classRoutine'].forEach((v) {
        classRoutine!.add(ClassRoutine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isWeekend'] = isWeekend;
    data['date'] = date;
    if (classRoutine != null) {
      data['classRoutine'] = classRoutine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassRoutine {
  int? day;
  String? startTime;
  String? endTime;
  String? subjectName;
  String? subjectCode;
  String? room;
  String? teacher;

  ClassRoutine(
      {this.day,
        this.startTime,
        this.endTime,
        this.subjectName,
        this.subjectCode,
        this.room,
        this.teacher});

  ClassRoutine.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    room = json['room'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['subject_name'] = subjectName;
    data['subject_code'] = subjectCode;
    data['room'] = room;
    data['teacher'] = teacher;
    return data;
  }
}
