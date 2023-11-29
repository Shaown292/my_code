class AdminStudentSearchAttendanceResponseModel {
  bool? success;
  AttendanceStudentData? data;
  String? message;

  AdminStudentSearchAttendanceResponseModel(
      {this.success, this.data, this.message});

  AdminStudentSearchAttendanceResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AttendanceStudentData.fromJson(json['data']) : null;
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

class AttendanceStudentData {
  String? submittedMessage;
  String? className;
  String? sectionName;
  String? date;
  List<StudentsListData>? students;
  String? status;

  AttendanceStudentData(
      {this.submittedMessage,
        this.className,
        this.sectionName,
        this.date,
        this.students,
        this.status});

  AttendanceStudentData.fromJson(Map<String, dynamic> json) {
    submittedMessage = json['submitted_message'];
    className = json['class_name'];
    sectionName = json['section_name'];
    date = json['date'];
    if (json['students'] != null) {
      students = <StudentsListData>[];
      json['students'].forEach((v) {
        students!.add(StudentsListData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['submitted_message'] = submittedMessage;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['date'] = date;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class StudentsListData {
  int? id;
  int? admissionNo;
  String? fullName;
  int? rollNo;
  String? note;
  String? attendanceType;

  StudentsListData(
      {this.id,
        this.admissionNo,
        this.fullName,
        this.rollNo,
        this.note,
        this.attendanceType});

  StudentsListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admissionNo = json['admission_no'];
    fullName = json['full_name'];
    rollNo = json['roll_no'];
    note = json['note'];
    attendanceType = json['attendance_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admission_no'] = admissionNo;
    data['full_name'] = fullName;
    data['roll_no'] = rollNo;
    data['note'] = note;
    data['attendance_type'] = attendanceType;
    return data;
  }
}
