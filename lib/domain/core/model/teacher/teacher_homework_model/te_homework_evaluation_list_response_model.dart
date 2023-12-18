class TeHomeworkEvaluationListResponseModel {
  bool? success;
  Data? data;
  String? message;

  TeHomeworkEvaluationListResponseModel(
      {this.success, this.data, this.message});

  TeHomeworkEvaluationListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<EvaluationSubjectData>? subject;

  Data({this.subject});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subject'] != null) {
      subject = <EvaluationSubjectData>[];
      json['subject'].forEach((v) {
        subject!.add(EvaluationSubjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subject != null) {
      data['subject'] = subject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EvaluationSubjectData {
  int? id;
  String? subjectName;
  String? evaluateDate;
  String? file;
  int? marks;
  String? submissionDate;

  EvaluationSubjectData(
      {this.id,
        this.subjectName,
        this.evaluateDate,
        this.file,
        this.marks,
        this.submissionDate});

  EvaluationSubjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    evaluateDate = json['evaluate_date'];
    file = json['file'];
    marks = json['marks'];
    submissionDate = json['submission_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['evaluate_date'] = evaluateDate;
    data['file'] = file;
    data['marks'] = marks;
    data['submission_date'] = submissionDate;
    return data;
  }
}
