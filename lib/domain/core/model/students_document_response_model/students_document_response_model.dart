class StudentDocumentsResponseModel {
  bool? success;
  DocumentsListData? data;
  String? message;

  StudentDocumentsResponseModel({this.success, this.data, this.message});

  StudentDocumentsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DocumentsListData.fromJson(json['data']) : null;
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

class DocumentsListData {
  List<ProfileDocuments>? profileDocuments;
  List<ShowPermission>? showPermission;

  DocumentsListData({this.profileDocuments, this.showPermission});

  DocumentsListData.fromJson(Map<String, dynamic> json) {
    if (json['profileDocuments'] != null) {
      profileDocuments = <ProfileDocuments>[];
      json['profileDocuments'].forEach((v) {
        profileDocuments!.add(ProfileDocuments.fromJson(v));
      });
    }
    if (json['show_permission'] != null) {
      showPermission = <ShowPermission>[];
      json['show_permission'].forEach((v) {
        showPermission!.add(ShowPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileDocuments != null) {
      data['profileDocuments'] =
          profileDocuments!.map((v) => v.toJson()).toList();
    }
    if (showPermission != null) {
      data['show_permission'] =
          showPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileDocuments {
  int? id;
  String? title;
  String? file;

  ProfileDocuments({this.id, this.title, this.file});

  ProfileDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['file'] = file;
    return data;
  }
}

class ShowPermission {
  String? fieldName;
  int? isShow;

  ShowPermission({this.fieldName, this.isShow});

  ShowPermission.fromJson(Map<String, dynamic> json) {
    fieldName = json['field_name'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field_name'] = fieldName;
    data['is_show'] = isShow;
    return data;
  }
}
