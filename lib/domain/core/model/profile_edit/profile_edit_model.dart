class ProfileEditModel {
  bool? success;
  Data? data;
  String? message;

  ProfileEditModel({this.success, this.data, this.message});

  ProfileEditModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  StudentDetail? studentDetail;
  List<EditPermission>? editPermission;

  Data({this.studentDetail, this.editPermission});

  Data.fromJson(Map<String, dynamic> json) {
    studentDetail = json['student_detail'] != null
        ?  StudentDetail.fromJson(json['student_detail'])
        : null;
    if (json['edit_permission'] != null) {
      editPermission = <EditPermission>[];
      json['edit_permission'].forEach((v) {
        editPermission!.add( EditPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (studentDetail != null) {
      data['student_detail'] = studentDetail!.toJson();
    }
    if (editPermission != null) {
      data['edit_permission'] =
          editPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDetail {
  String? studentPhoto;
  String? firstName;
  String? lastName;
  int? admissionNo;
  String? dateOfBirth;
  int? age;
  String? mobile;
  String? email;
  String? currentAddress;

  StudentDetail(
      {this.studentPhoto,
        this.firstName,
        this.lastName,
        this.admissionNo,
        this.dateOfBirth,
        this.age,
        this.mobile,
        this.email,
        this.currentAddress});

  StudentDetail.fromJson(Map<String, dynamic> json) {
    studentPhoto = json['student_photo'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    admissionNo = json['admission_no'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    mobile = json['mobile'];
    email = json['email'];
    currentAddress = json['current_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_photo'] = studentPhoto;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['admission_no'] = admissionNo;
    data['date_of_birth'] = dateOfBirth;
    data['age'] = age;
    data['mobile'] = mobile;
    data['email'] = email;
    data['current_address'] = currentAddress;
    return data;
  }
}

class EditPermission {
  String? fieldName;
  int? studentEdit;

  EditPermission({this.fieldName, this.studentEdit});

  EditPermission.fromJson(Map<String, dynamic> json) {
    fieldName = json['field_name'];
    studentEdit = json['student_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field_name'] = fieldName;
    data['student_edit'] = studentEdit;
    return data;
  }
}
