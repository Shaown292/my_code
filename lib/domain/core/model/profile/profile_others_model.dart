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
  List<ShowPermission>? showPermission;

  Data({this.profileOthers, this.showPermission});

  Data.fromJson(Map<String, dynamic> json) {
    profileOthers = json['profileOthers'] != null
        ? ProfileOthers.fromJson(json['profileOthers'])
        : null;
    if (json['show_permission'] != null) {
      showPermission = <ShowPermission>[];
      json['show_permission'].forEach((v) {
        showPermission!.add(ShowPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileOthers != null) {
      data['profileOthers'] = profileOthers!.toJson();
    }
    if (showPermission != null) {
      data['show_permission'] =
          showPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileOthers {
  double? height;
  double? weight;
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
    height = json['height'];
    weight = json['weight'];
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
