class AdminLibraryAddMemberClassResponseModel {
  bool? success;
  List<AdminLibraryAddMemberClassData>? data;
  String? message;

  AdminLibraryAddMemberClassResponseModel(
      {this.success, this.data, this.message});

  AdminLibraryAddMemberClassResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminLibraryAddMemberClassData>[];
      json['data'].forEach((v) {
        data!.add(AdminLibraryAddMemberClassData.fromJson(v));
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

class AdminLibraryAddMemberClassData {
  int? id;
  String? className;

  AdminLibraryAddMemberClassData({this.id, this.className});

  AdminLibraryAddMemberClassData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = className;
    return data;
  }
}
