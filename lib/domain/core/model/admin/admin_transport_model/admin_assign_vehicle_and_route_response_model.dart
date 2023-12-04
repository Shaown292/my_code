class AdminAssignVehicleAndRouteResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminAssignVehicleAndRouteResponseModel(
      {this.success, this.data, this.message});

  AdminAssignVehicleAndRouteResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<AdminVehicleAssignRoutes>? routes;
  List<AdminVehicleAssignVehicles>? vehicles;

  Data({this.routes, this.vehicles});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <AdminVehicleAssignRoutes>[];
      json['routes'].forEach((v) {
        routes!.add(AdminVehicleAssignRoutes.fromJson(v));
      });
    }
    if (json['vehicles'] != null) {
      vehicles = <AdminVehicleAssignVehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(AdminVehicleAssignVehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    if (vehicles != null) {
      data['vehicles'] = vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminVehicleAssignRoutes {
  int? id;
  String? title;

  AdminVehicleAssignRoutes({this.id, this.title});

  AdminVehicleAssignRoutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class AdminVehicleAssignVehicles {
  int? id;
  String? vehicleNo;

  AdminVehicleAssignVehicles({this.id, this.vehicleNo});

  AdminVehicleAssignVehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNo = json['vehicle_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_no'] = vehicleNo;
    return data;
  }
}
