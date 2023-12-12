class TeacherHomeworkListResponseModel {
  bool? success;
  List<TeacherHomeworkData>? data;
  String? message;

  TeacherHomeworkListResponseModel({this.success, this.data, this.message});

  TeacherHomeworkListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherHomeworkData>[];
      json['data'].forEach((v) {
        data!.add(TeacherHomeworkData.fromJson(v));
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

class TeacherHomeworkData {
  int? id;
  String? subjectName;
  String? creationDate;
  String? submissionDate;
  String? evaluation;
  int? marks;
  String? file;

  TeacherHomeworkData(
      {this.id,
        this.subjectName,
        this.creationDate,
        this.submissionDate,
        this.evaluation,
        this.marks,
        this.file});

  TeacherHomeworkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    creationDate = json['creation_date'];
    submissionDate = json['submission_date'];
    evaluation = json['evaluation'];
    marks = json['marks'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['creation_date'] = creationDate;
    data['submission_date'] = submissionDate;
    data['evaluation'] = evaluation;
    data['marks'] = marks;
    data['file'] = file;
    return data;
  }
}