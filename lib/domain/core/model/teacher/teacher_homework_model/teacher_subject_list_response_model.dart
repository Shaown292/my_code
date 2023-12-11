class TeacherSubjectListResponseModel {
  bool? success;
  List<TeachetSubjectListData>? data;
  String? message;

  TeacherSubjectListResponseModel({this.success, this.data, this.message});

  TeacherSubjectListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeachetSubjectListData>[];
      json['data'].forEach((v) {
        data!.add(TeachetSubjectListData.fromJson(v));
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

class TeachetSubjectListData {
  int? id;
  String? subjectName;

  TeachetSubjectListData({this.id, this.subjectName});

  TeachetSubjectListData.fromJson(Map<String, dynamic> json) {
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
