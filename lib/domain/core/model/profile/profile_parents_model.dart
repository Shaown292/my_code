class ProfileParentsModel {
  bool? success;
  Data? data;
  String? message;

  ProfileParentsModel({this.success, this.data, this.message});

  ProfileParentsModel.fromJson(Map<String, dynamic> json) {
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
  ProfileParents? profileParents;
  List<ShowPermission>? showPermission;

  Data({this.profileParents, this.showPermission});

  Data.fromJson(Map<String, dynamic> json) {
    profileParents = json['profileParents'] != null
        ? ProfileParents.fromJson(json['profileParents'])
        : null;
    if (json['show_permission'] != null) {
      showPermission = <ShowPermission>[];
      json['show_permission'].forEach((v) {
        showPermission!.add( ShowPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileParents != null) {
      data['profileParents'] = profileParents!.toJson();
    }
    if (showPermission != null) {
      data['show_permission'] =
          showPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileParents {
  int? id;
  String? fathersName;
  String? fathersMobile;
  String? fathersOccupation;
  String? fathersPhoto;
  String? mothersName;
  String? mothersMobile;
  String? mothersOccupation;
  String? mothersPhoto;
  String? guardiansName;
  String? guardiansMobile;
  String? guardiansEmail;
  String? guardiansOccupation;
  String? guardiansRelation;
  String? guardiansPhoto;

  ProfileParents(
      {this.id,
        this.fathersName,
        this.fathersMobile,
        this.fathersOccupation,
        this.fathersPhoto,
        this.mothersName,
        this.mothersMobile,
        this.mothersOccupation,
        this.mothersPhoto,
        this.guardiansName,
        this.guardiansMobile,
        this.guardiansEmail,
        this.guardiansOccupation,
        this.guardiansRelation,
        this.guardiansPhoto});

  ProfileParents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fathersName = json['fathers_name'];
    fathersMobile = json['fathers_mobile'];
    fathersOccupation = json['fathers_occupation'];
    fathersPhoto = json['fathers_photo'];
    mothersName = json['mothers_name'];
    mothersMobile = json['mothers_mobile'];
    mothersOccupation = json['mothers_occupation'];
    mothersPhoto = json['mothers_photo'];
    guardiansName = json['guardians_name'];
    guardiansMobile = json['guardians_mobile'];
    guardiansEmail = json['guardians_email'];
    guardiansOccupation = json['guardians_occupation'];
    guardiansRelation = json['guardians_relation'];
    guardiansPhoto = json['guardians_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['fathers_name'] = fathersName;
    data['fathers_mobile'] = fathersMobile;
    data['fathers_occupation'] = fathersOccupation;
    data['fathers_photo'] = fathersPhoto;
    data['mothers_name'] = mothersName;
    data['mothers_mobile'] = mothersMobile;
    data['mothers_occupation'] = mothersOccupation;
    data['mothers_photo'] = mothersPhoto;
    data['guardians_name'] = guardiansName;
    data['guardians_mobile'] = guardiansMobile;
    data['guardians_email'] = guardiansEmail;
    data['guardians_occupation'] = guardiansOccupation;
    data['guardians_relation'] = guardiansRelation;
    data['guardians_photo'] = guardiansPhoto;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['field_name'] = fieldName;
    data['is_show'] = isShow;
    return data;
  }
}
