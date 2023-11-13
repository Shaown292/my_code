class StudentAttendanceResponseModel {
  bool? success;
  Data? data;
  String? message;

  StudentAttendanceResponseModel({this.success, this.data, this.message});

  StudentAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Attendances>? attendances;
  PreviousMonthDetails? previousMonthDetails;
  int? days;
  int? year;
  int? month;
  String? currentDay;
  String? status;

  Data(
      {this.attendances,
        this.previousMonthDetails,
        this.days,
        this.year,
        this.month,
        this.currentDay,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['attendances'] != null) {
      attendances = <Attendances>[];
      json['attendances'].forEach((v) {
        attendances!.add(Attendances.fromJson(v));
      });
    }
    previousMonthDetails = json['previousMonthDetails'] != null
        ? PreviousMonthDetails.fromJson(json['previousMonthDetails'])
        : null;
    days = json['days'];
    year = json['year'];
    month = json['month'];
    currentDay = json['current_day'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attendances != null) {
      data['attendances'] = attendances!.map((v) => v.toJson()).toList();
    }
    if (previousMonthDetails != null) {
      data['previousMonthDetails'] = previousMonthDetails!.toJson();
    }
    data['days'] = days;
    data['year'] = year;
    data['month'] = month;
    data['current_day'] = currentDay;
    data['status'] = status;
    return data;
  }
}

class Attendances {
  String? attendanceType;
  DateTime? attendanceDate;

  Attendances({this.attendanceType, this.attendanceDate});

  Attendances.fromJson(Map<String, dynamic> json) {
    attendanceType = json['attendance_type'];
    attendanceDate = DateTime.tryParse(json['attendance_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_type'] = attendanceType;
    data['attendance_date'] = attendanceDate;
    return data;
  }
}

class PreviousMonthDetails {
  String? date;
  int? day;
  String? weekName;

  PreviousMonthDetails({this.date, this.day, this.weekName});

  PreviousMonthDetails.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    weekName = json['week_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['week_name'] = weekName;
    return data;
  }
}
