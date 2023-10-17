class ProfilePersonalModel {
  bool? success;
  Data? data;
  String? message;

  ProfilePersonalModel({this.success, this.data, this.message});

  ProfilePersonalModel.fromJson(Map<String, dynamic> json) {
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
  ProfilePersonal? profilePersonal;
  List<ShowPermission>? showPermission;

  Data({this.profilePersonal, this.showPermission});

  Data.fromJson(Map<String, dynamic> json) {
    profilePersonal = json['profilePersonal'] != null
        ?  ProfilePersonal.fromJson(json['profilePersonal'])
        : null;
    if (json['show_permission'] != null) {
      showPermission = <ShowPermission>[];
      json['show_permission'].forEach((v) {
        showPermission!.add( ShowPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (profilePersonal != null) {
      data['profilePersonal'] = profilePersonal!.toJson();
    }
    if (showPermission != null) {
      data['show_permission'] =
          showPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfilePersonal {
  int? id;
  String? studentPhoto;
  String? firstName;
  String? lastName;
  int? admissionNo;
  String? dateOfBirth;
  int? age;
  String? mobile;
  String? email;
  String? currentAddress;
  String? permanentAddress;
  String? bloodGroup;
  String? religion;

  ProfilePersonal(
      {this.id,
        this.studentPhoto,
        this.firstName,
        this.lastName,
        this.admissionNo,
        this.dateOfBirth,
        this.age,
        this.mobile,
        this.email,
        this.currentAddress,
        this.permanentAddress,
        this.bloodGroup,
        this.religion});

  ProfilePersonal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentPhoto = json['student_photo'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    admissionNo = json['admission_no'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    mobile = json['mobile'];
    email = json['email'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_photo'] = studentPhoto;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['admission_no'] = admissionNo;
    data['date_of_birth'] = dateOfBirth;
    data['age'] = age;
    data['mobile'] = mobile;
    data['email'] = email;
    data['current_address'] = currentAddress;
    data['permanent_address'] = permanentAddress;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
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
