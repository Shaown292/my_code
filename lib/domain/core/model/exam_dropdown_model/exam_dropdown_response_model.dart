import 'dart:convert';

ExamDropdownResponseModel examDropdownResponseModelFromJson(String str) => ExamDropdownResponseModel.fromJson(json.decode(str));

String examDropdownResponseModelToJson(ExamDropdownResponseModel data) => json.encode(data.toJson());

class ExamDropdownResponseModel {
  bool success;
  List<ExamDataList> data;
  String message;

  ExamDropdownResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ExamDropdownResponseModel.fromJson(Map<String, dynamic> json) => ExamDropdownResponseModel(
    success: json["success"],
    data: List<ExamDataList>.from(json["data"].map((x) => ExamDataList.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class ExamDataList {
  int id;
  String examType;
  String datumClass;
  String section;

  ExamDataList({
    required this.id,
    required this.examType,
    required this.datumClass,
    required this.section,
  });

  factory ExamDataList.fromJson(Map<String, dynamic> json) => ExamDataList(
    id: json["id"],
    examType: json["exam_type"],
    datumClass: json["class"],
    section: json["section"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_type": examType,
    "class": datumClass,
    "section": section,
  };
}
