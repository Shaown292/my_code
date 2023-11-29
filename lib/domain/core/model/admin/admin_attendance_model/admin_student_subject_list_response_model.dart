class AdminStudentSubjectListResponseModel {
  bool? success;
  List<SubjectData>? data;
  String? message;

  AdminStudentSubjectListResponseModel({this.success, this.data, this.message});

  AdminStudentSubjectListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SubjectData>[];
      json['data'].forEach((v) {
        data!.add(SubjectData.fromJson(v));
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

class SubjectData {
  int? id;
  String? subjectName;

  SubjectData({this.id, this.subjectName});

  SubjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    return data;
  }
}
