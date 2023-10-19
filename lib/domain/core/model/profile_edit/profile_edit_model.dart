class ProfileEditModel {
  bool? success;
  Data? data;
  String? message;

  ProfileEditModel({this.success, this.data, this.message});

  ProfileEditModel.fromJson(Map<String, dynamic> json) {
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
  ProfilePersonalUpdate? profilePersonalUpdate;

  Data({this.profilePersonalUpdate});

  Data.fromJson(Map<String, dynamic> json) {
    profilePersonalUpdate = json['profilePersonal'] != null
        ? ProfilePersonalUpdate.fromJson(json['profilePersonal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profilePersonalUpdate != null) {
      data['profilePersonal'] = profilePersonalUpdate!.toJson();
    }
    return data;
  }
}

class ProfilePersonalUpdate {
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

  ProfilePersonalUpdate(
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

  ProfilePersonalUpdate.fromJson(Map<String, dynamic> json) {
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
