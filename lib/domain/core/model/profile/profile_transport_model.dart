class ProfileTransportModel {
  bool? success;
  Data? data;
  String? message;

  ProfileTransportModel({this.success, this.data, this.message});

  ProfileTransportModel.fromJson(Map<String, dynamic> json) {
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
  ProfileTransport? profileTransport;
  List<ShowPermission>? showPermission;

  Data({this.profileTransport, this.showPermission});

  Data.fromJson(Map<String, dynamic> json) {
    profileTransport = json['profileTransport'] != null
        ? ProfileTransport.fromJson(json['profileTransport'])
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
    if (profileTransport != null) {
      data['profileTransport'] = profileTransport!.toJson();
    }
    if (showPermission != null) {
      data['show_permission'] =
          showPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileTransport {
  int? id;
  String? route;
  String? vehicle;
  String? dormitory;
  String? driver;
  String? mobile;

  ProfileTransport(
      {this.id,
        this.route,
        this.vehicle,
        this.dormitory,
        this.driver,
        this.mobile});

  ProfileTransport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    route = json['route'];
    vehicle = json['vehicle'];
    dormitory = json['dormitory'];
    driver = json['driver'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route'] = route;
    data['vehicle'] = vehicle;
    data['dormitory'] = dormitory;
    data['driver'] = driver;
    data['mobile'] = mobile;
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
