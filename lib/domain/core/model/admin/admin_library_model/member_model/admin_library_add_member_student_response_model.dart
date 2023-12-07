class AdminLibraryAddMemberStudentResponseModel {
  bool? success;
  List<AdminLibraryAddMemberStudentData>? data;
  String? message;

  AdminLibraryAddMemberStudentResponseModel(
      {this.success, this.data, this.message});

  AdminLibraryAddMemberStudentResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminLibraryAddMemberStudentData>[];
      json['data'].forEach((v) {
        data!.add(AdminLibraryAddMemberStudentData.fromJson(v));
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

class AdminLibraryAddMemberStudentData {
  int? id;
  String? fullName;
  int? userId;

  AdminLibraryAddMemberStudentData({this.id, this.fullName, this.userId});

  AdminLibraryAddMemberStudentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['user_id'] = userId;
    return data;
  }
}
