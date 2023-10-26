class StudentOthersDownloadResponseModel {
  bool? success;
  List<StudentOthersDownloadData>? data;
  String? message;

  StudentOthersDownloadResponseModel({this.success, this.data, this.message});

  StudentOthersDownloadResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StudentOthersDownloadData>[];
      json['data'].forEach((v) {
        data!.add(StudentOthersDownloadData.fromJson(v));
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

class StudentOthersDownloadData {
  int? id;
  String? uploadDate;
  String? contentTitle;
  String? availableFor;

  StudentOthersDownloadData({this.id, this.uploadDate, this.contentTitle, this.availableFor});

  StudentOthersDownloadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadDate = json['upload_date'];
    contentTitle = json['content_title'];
    availableFor = json['available_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['upload_date'] = uploadDate;
    data['content_title'] = contentTitle;
    data['available_for'] = availableFor;
    return data;
  }
}
