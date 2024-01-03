class PaymentMethodListResponseModel {
  bool? success;
  List<String>? data;
  String? message;

  PaymentMethodListResponseModel({this.success, this.data, this.message});

  PaymentMethodListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
