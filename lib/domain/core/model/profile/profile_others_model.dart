class ProfileOthersModel {
  bool? success;
  Data? data;
  String? message;

  ProfileOthersModel({this.success, this.data, this.message});

  ProfileOthersModel.fromJson(Map<String, dynamic> json) {
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
  ProfileOthers? profileOthers;
  ProfileOthersPermissions? showPermission;

  Data({this.profileOthers, this.showPermission});

  Data.fromJson(Map<String, dynamic> json) {
    profileOthers = json['profileOthers'] != null ? ProfileOthers.fromJson(json['profileOthers']) : null;
    showPermission = json['show_permission'] != null ? ProfileOthersPermissions.fromJson(json['show_permission']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileOthers != null) {
      data['profileOthers'] = profileOthers!.toJson();
    }
    if (showPermission != null) {
      data['show_permission'] = showPermission!.toJson();
    }
    return data;
  }
}

class ProfileOthers {
  String? height;
  String? weight;
  String? nationalIdNo;
  String? localIdNo;
  String? bankName;
  String? bankAccountNo;

  ProfileOthers(
      {this.height,
        this.weight,
        this.nationalIdNo,
        this.localIdNo,
        this.bankName,
        this.bankAccountNo});

  ProfileOthers.fromJson(Map<String, dynamic> json) {
    height = json['height'].runtimeType == int ? json['height'].toString() : json['height'];
    weight = json['weight'].runtimeType == int ? json['weight'].toString() : json['weight'];
    nationalIdNo = json['national_id_no'];
    localIdNo = json['local_id_no'];
    bankName = json['bank_name'];
    bankAccountNo = json['bank_account_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['weight'] = weight;
    data['national_id_no'] = nationalIdNo;
    data['local_id_no'] = localIdNo;
    data['bank_name'] = bankName;
    data['bank_account_no'] = bankAccountNo;
    return data;
  }
}

class ProfileOthersPermissions {
  int? session;
  int? studentClass;
  int? section;
  int? rollNumber;
  int? admissionNumber;
  int? firstName;
  int? lastName;
  int? gender;
  int? dateOfBirth;
  int? bloodGroup;
  int? emailAddress;
  int? caste;
  int? phoneNumber;
  int? religion;
  int? admissionDate;
  int? studentCategoryId;
  int? studentGroupId;
  int? height;
  int? weight;
  int? photo;
  int? fathersName;
  int? fathersOccupation;
  int? fathersPhone;
  int? fathersPhoto;
  int? mothersName;
  int? mothersOccupation;
  int? mothersPhone;
  int? mothersPhoto;
  int? guardiansName;
  int? guardiansEmail;
  int? guardiansPhoto;
  int? guardiansPhone;
  int? guardiansOccupation;
  int? guardiansAddress;
  int? currentAddress;
  int? permanentAddress;
  int? route;
  int? vehicle;
  int? dormitoryName;
  int? roomNumber;
  int? nationalIdNumber;
  int? localIdNumber;
  int? bankAccountNumber;
  int? bankName;
  int? previousSchoolDetails;
  int? additionalNotes;
  int? ifscCode;
  int? documentFile1;
  int? documentFile2;
  int? documentFile3;
  int? documentFile4;
  int? customField;

  ProfileOthersPermissions(
      {this.session,
        this.studentClass,
        this.section,
        this.rollNumber,
        this.admissionNumber,
        this.firstName,
        this.lastName,
        this.gender,
        this.dateOfBirth,
        this.bloodGroup,
        this.emailAddress,
        this.caste,
        this.phoneNumber,
        this.religion,
        this.admissionDate,
        this.studentCategoryId,
        this.studentGroupId,
        this.height,
        this.weight,
        this.photo,
        this.fathersName,
        this.fathersOccupation,
        this.fathersPhone,
        this.fathersPhoto,
        this.mothersName,
        this.mothersOccupation,
        this.mothersPhone,
        this.mothersPhoto,
        this.guardiansName,
        this.guardiansEmail,
        this.guardiansPhoto,
        this.guardiansPhone,
        this.guardiansOccupation,
        this.guardiansAddress,
        this.currentAddress,
        this.permanentAddress,
        this.route,
        this.vehicle,
        this.dormitoryName,
        this.roomNumber,
        this.nationalIdNumber,
        this.localIdNumber,
        this.bankAccountNumber,
        this.bankName,
        this.previousSchoolDetails,
        this.additionalNotes,
        this.ifscCode,
        this.documentFile1,
        this.documentFile2,
        this.documentFile3,
        this.documentFile4,
        this.customField});

  ProfileOthersPermissions.fromJson(Map<String, dynamic> json) {
    session = json['session'];
    studentClass = json['studentClass'];
    section = json['section'];
    rollNumber = json['roll_number'];
    admissionNumber = json['admission_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    emailAddress = json['email_address'];
    caste = json['caste'];
    phoneNumber = json['phone_number'];
    religion = json['religion'];
    admissionDate = json['admission_date'];
    studentCategoryId = json['student_category_id'];
    studentGroupId = json['student_group_id'];
    height = json['height'];
    weight = json['weight'];
    photo = json['photo'];
    fathersName = json['fathers_name'];
    fathersOccupation = json['fathers_occupation'];
    fathersPhone = json['fathers_phone'];
    fathersPhoto = json['fathers_photo'];
    mothersName = json['mothers_name'];
    mothersOccupation = json['mothers_occupation'];
    mothersPhone = json['mothers_phone'];
    mothersPhoto = json['mothers_photo'];
    guardiansName = json['guardians_name'];
    guardiansEmail = json['guardians_email'];
    guardiansPhoto = json['guardians_photo'];
    guardiansPhone = json['guardians_phone'];
    guardiansOccupation = json['guardians_occupation'];
    guardiansAddress = json['guardians_address'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    route = json['route'];
    vehicle = json['vehicle'];
    dormitoryName = json['dormitory_name'];
    roomNumber = json['room_number'];
    nationalIdNumber = json['national_id_number'];
    localIdNumber = json['local_id_number'];
    bankAccountNumber = json['bank_account_number'];
    bankName = json['bank_name'];
    previousSchoolDetails = json['previous_school_details'];
    additionalNotes = json['additional_notes'];
    ifscCode = json['ifsc_code'];
    documentFile1 = json['document_file_1'];
    documentFile2 = json['document_file_2'];
    documentFile3 = json['document_file_3'];
    documentFile4 = json['document_file_4'];
    customField = json['custom_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session'] = this.session;
    data['studentClass'] = this.studentClass;
    data['section'] = this.section;
    data['roll_number'] = this.rollNumber;
    data['admission_number'] = this.admissionNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    data['email_address'] = this.emailAddress;
    data['caste'] = this.caste;
    data['phone_number'] = this.phoneNumber;
    data['religion'] = this.religion;
    data['admission_date'] = this.admissionDate;
    data['student_category_id'] = this.studentCategoryId;
    data['student_group_id'] = this.studentGroupId;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['photo'] = this.photo;
    data['fathers_name'] = this.fathersName;
    data['fathers_occupation'] = this.fathersOccupation;
    data['fathers_phone'] = this.fathersPhone;
    data['fathers_photo'] = this.fathersPhoto;
    data['mothers_name'] = this.mothersName;
    data['mothers_occupation'] = this.mothersOccupation;
    data['mothers_phone'] = this.mothersPhone;
    data['mothers_photo'] = this.mothersPhoto;
    data['guardians_name'] = this.guardiansName;
    data['guardians_email'] = this.guardiansEmail;
    data['guardians_photo'] = this.guardiansPhoto;
    data['guardians_phone'] = this.guardiansPhone;
    data['guardians_occupation'] = this.guardiansOccupation;
    data['guardians_address'] = this.guardiansAddress;
    data['current_address'] = this.currentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['route'] = this.route;
    data['vehicle'] = this.vehicle;
    data['dormitory_name'] = this.dormitoryName;
    data['room_number'] = this.roomNumber;
    data['national_id_number'] = this.nationalIdNumber;
    data['local_id_number'] = this.localIdNumber;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_name'] = this.bankName;
    data['previous_school_details'] = this.previousSchoolDetails;
    data['additional_notes'] = this.additionalNotes;
    data['ifsc_code'] = this.ifscCode;
    data['document_file_1'] = this.documentFile1;
    data['document_file_2'] = this.documentFile2;
    data['document_file_3'] = this.documentFile3;
    data['document_file_4'] = this.documentFile4;
    data['custom_field'] = this.customField;
    return data;
  }
}
